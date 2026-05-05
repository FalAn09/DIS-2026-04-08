#!/bin/bash
set -e

# Deploy script for AWS EC2 instance
# Usage: sudo bash deploy_ec2.sh <github_repo_url> <branch>

REPO_URL=${1:-https://github.com/FalAn09/DIS-2026-04-08.git}
BRANCH=${2:-main}
APP_DIR=/home/ec2-user/fullstack-hello-world

function install_yum_packages() {
  yum update -y
  yum install -y git curl unzip
  amazon-linux-extras enable docker
  yum install -y docker
  systemctl enable docker
  systemctl start docker
}

function install_apt_packages() {
  apt-get update -y
  apt-get install -y git curl unzip ca-certificates
  apt-get install -y docker.io
  systemctl enable docker
  systemctl start docker
}

function install_docker_compose() {
  if ! command -v docker-compose >/dev/null 2>&1; then
    echo "Installing docker-compose..."
    DOCKER_COMPOSE_VERSION=2.17.3
    curl -L "https://github.com/docker/compose/releases/download/v${DOCKER_COMPOSE_VERSION}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
  fi
}

function install_packages() {
  if [ -f /etc/os-release ]; then
    . /etc/os-release
    if [[ "$ID" == "amzn" || "$ID_LIKE" =~ "rhel" ]]; then
      install_yum_packages
    elif [[ "$ID" == "ubuntu" || "$ID" == "debian" ]]; then
      install_apt_packages
    else
      echo "Unsupported OS: $ID"
      exit 1
    fi
  else
    echo "/etc/os-release not found. Cannot determine OS."
    exit 1
  fi
}

function prepare_repo() {
  if [ -d "$APP_DIR/.git" ]; then
    echo "Repository already exists, updating..."
    cd "$APP_DIR"
    git fetch origin
    git checkout "$BRANCH"
    git reset --hard "origin/$BRANCH"
  else
    echo "Cloning repository..."
    git clone "$REPO_URL" "$APP_DIR"
    cd "$APP_DIR"
    git checkout "$BRANCH"
  fi
}

function deploy_app() {
  cd "$APP_DIR"
  chmod +x deploy_ec2.sh || true
  if [ -f docker-compose.yml ]; then
    docker-compose down || true
    docker-compose up -d --build
  else
    echo "docker-compose.yml not found in $APP_DIR"
    exit 1
  fi
}

function main() {
  install_packages
  install_docker_compose
  usermod -aG docker ec2-user || true
  prepare_repo
  deploy_app
  echo "Deployment completed. Access the app via the EC2 public IP or configured load balancer."
}

main

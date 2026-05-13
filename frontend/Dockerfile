FROM nginx:alpine

# DEV Environment Image
LABEL environment="development"
LABEL branch="dev"
LABEL description="Frontend UI - Development Environment"

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY . /usr/share/nginx/html

EXPOSE 80
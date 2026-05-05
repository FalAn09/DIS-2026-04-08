# Full Stack Hello World

A simple full-stack application with Python backend, HTML frontend, SQLite database, consuming a third-party API.

## Setup

1. Ensure Docker and Docker Compose are installed.

2. Run `docker-compose up --build`

3. Open http://localhost for frontend.

4. Click "Get Hello" to fetch from backend.

## GitHub

This project is set up for GitHub. Create a repo and push.

To push to dev branch:

git init

git add .

git commit -m "Initial commit"

git branch -M dev

git remote add origin <your-repo-url>

git push -u origin dev

## AWS Deployment

1. Conecta por SSH a tu instancia EC2 `Produccion`.
2. Copia el script `deploy_ec2.sh` a la instancia o usa el repositorio.
3. Ejecuta en la instancia:

```bash
sudo bash deploy_ec2.sh https://github.com/FalAn09/DIS-2026-04-08.git main
```

Esto instalará Docker, Git y Docker Compose, clonará la rama `main` y levantará la app con `docker-compose`.

### Notas
- La instancia debe poder acceder a GitHub por HTTPS.
- Si el repositorio es privado, usa una clave SSH o token de acceso para clonar.
- El frontend quedará expuesto en el puerto `80` y el backend en el puerto `5000`.
- Si tu instancia usa otro usuario, ajusta el script o ejecuta con el usuario correcto.


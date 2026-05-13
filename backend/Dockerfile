FROM python:3.9-slim

# DEV Environment Image
LABEL environment="development"
LABEL branch="dev"
LABEL description="Backend API - Development Environment"

ENV FLASK_ENV=development
ENV DEBUG_MODE=true

WORKDIR /app

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
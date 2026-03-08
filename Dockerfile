FROM python:3.11-slim

# Install system dependencies
RUN apt-get update && apt-get install -y libpq-dev gcc && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Copy requirements
COPY requirements.txt .

# Install python dependencies
RUN pip install --no-cache-dir -r requirements.txt
RUN pip install gunicorn python-dotenv

# Copy the rest of the application code
COPY . .

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV FLASK_APP=app/app.py
ENV PYTHONPATH=/app

# Expose dynamic port for Railway
EXPOSE ${PORT:-5005}

# Start the application using Gunicorn (allowing environment variables to evaluate)
CMD gunicorn --bind 0.0.0.0:${PORT:-5005} --workers 3 --threads 2 --timeout 120 --chdir app app:app

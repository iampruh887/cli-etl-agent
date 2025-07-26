# Use Python 3.11 slim image for smaller size
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
   gcc \
   g++ \
   && rm -rf /var/lib/apt/lists/*

# Copy requirements first for better Docker layer caching
COPY requirements.txt .

# Install base Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Fix binary incompatibility by forcing compatible versions
RUN pip uninstall -y numpy spacy thinc && \
    pip install --no-cache-dir numpy==1.24.4 spacy==3.7.2 thinc==8.2.2

# Copy application code
COPY improved_etl.py .
COPY .env* ./

# Create necessary directories
RUN mkdir -p /app/data /app/output /app/logs

# Set environment variables
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH=/app

# Create non-root user for security
RUN useradd --create-home --shell /bin/bash etl_user && \
    chown -R etl_user:etl_user /app
USER etl_user

# Entrypoint and default behavior
ENTRYPOINT ["python", "improved_etl.py"]
CMD ["--help"]

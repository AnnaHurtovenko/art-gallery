FROM python:3.10

# Install the necessary packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    dnsutils \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the project files
COPY . /app

# Set dependencies
RUN pip install --no-cache-dir -r requirements.txt gunicorn

# Open port 8001
EXPOSE 8001

# Start the server via Gunicorn
CMD ["gunicorn", "--bind", "0.0.0.0:8001", "backend_redis.wsgi:application"]






























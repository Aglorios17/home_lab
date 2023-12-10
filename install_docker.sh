#!/bin/bash

# Load environment variables from .env file
if [ -f .env ]; then
    source .env
else
    echo "Error: .env file not found."
    exit 1
fi

# Check if Docker is already installed
if ! command -v docker &> /dev/null; then
    echo "Installing Docker..."
    apt update
    apt install -y docker.io
    systemctl enable docker --now
    DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
    mkdir -p $DOCKER_CONFIG/cli-plugins
    curl -SL https://github.com/docker/compose/releases/download/v2.23.3/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
    chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
    sudo usermod -aG docker $USER
    docker compose version
    echo "Docker install just finished (sudo $USER)"
else
    echo "Docker is already installed. Skipping installation."
fi

# Log in to Docker
echo "Logging in to Docker..."
docker login -u "$DOCKER_USERNAME" -p "$DOCKER_PASSWORD"

# Check if the login was successful
if [ $? -eq 0 ]; then
    echo "Docker login successful."
    docker run hello-world
else
    echo "Error: Docker login failed."
    exit 1
fi
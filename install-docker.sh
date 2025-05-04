#!/bin/bash

# Docker installation script
# This script installs Docker and adds user 'patrick' to the docker group

# Exit on any error
set -e

echo "=== Starting Docker installation ==="

# Update package lists
echo "Updating package lists..."
sudo apt-get update

# Install prerequisites
echo "Installing prerequisites..."
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the Docker repository
echo "Setting up the Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package lists again with Docker repository
echo "Updating package lists with Docker repository..."
sudo apt-get update

# Install Docker Engine
echo "Installing Docker Engine..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Start and enable Docker service
echo "Starting and enabling Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

# Add user 'patrick' to the docker group
echo "Adding user 'patrick' to the docker group..."
sudo usermod -aG docker patrick

echo "=== Docker installation complete! ==="
echo "Note: You may need to log out and log back in for the docker group changes to take effect."
echo "To verify installation, log out and log back in, then run: docker --version"

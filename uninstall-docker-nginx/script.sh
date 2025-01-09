#!/bin/bash

# Exit script on error
set -e

# Uninstall Docker and related components
echo "Uninstalling Docker and related components..."
sudo apt remove --purge -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
sudo apt autoremove -y
sudo apt autoclean

# Remove Docker data and configuration
echo "Removing Docker data and configuration..."
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
sudo rm -rf /usr/local/bin/docker-compose
sudo rm -rf /etc/docker
sudo rm -rf /usr/share/keyrings/docker-archive-keyring.gpg
sudo rm -f /etc/apt/sources.list.d/docker.list

# Uninstall Nginx
echo "Uninstalling Nginx..."
sudo apt remove --purge -y nginx nginx-common nginx-core
sudo apt autoremove -y
sudo apt autoclean

# Remove Nginx configuration and data
echo "Removing Nginx data and configuration..."
sudo rm -rf /etc/nginx
sudo rm -rf /var/www/html
sudo rm -rf /var/log/nginx

# Verify uninstallation
echo "Verifying Docker uninstallation..."
if ! command -v docker &> /dev/null; then
  echo "Docker has been successfully uninstalled."
else
  echo "Docker is still installed."
fi

echo "Verifying Docker Compose uninstallation..."
if ! command -v docker-compose &> /dev/null; then
  echo "Docker Compose has been successfully uninstalled."
else
  echo "Docker Compose is still installed."
fi

echo "Verifying Nginx uninstallation..."
if ! command -v nginx &> /dev/null; then
  echo "Nginx has been successfully uninstalled."
else
  echo "Nginx is still installed."
fi

# Output success message
echo "Docker, Docker Compose, and Nginx uninstallation complete!"

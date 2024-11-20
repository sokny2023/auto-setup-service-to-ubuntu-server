#!/bin/bash

# Exit script on error
set -e

# Update package index
echo "Updating package index..."
sudo apt update -y && sudo apt upgrade -y

# Install required dependencies
echo "Installing dependencies..."
sudo apt install -y software-properties-common

# Add Ansible PPA repository
echo "Adding Ansible PPA repository..."
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Install Ansible
echo "Installing Ansible..."
sudo apt install -y ansible

# Verify Ansible installation
echo "Verifying Ansible installation..."
ansible --version

# Display success message
echo "Ansible installation completed successfully!"

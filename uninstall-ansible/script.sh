#!/bin/bash

# Exit script on error
set -e

# Stop any Ansible-related services or tasks
echo "Stopping any Ansible-related services or tasks (if running)..."

# Uninstall Ansible
echo "Uninstalling Ansible..."
sudo apt remove --purge -y ansible
sudo apt autoremove -y
sudo apt autoclean

# Remove Ansible PPA repository
echo "Removing Ansible PPA repository..."
sudo add-apt-repository --remove -y ppa:ansible/ansible

# Remove any remaining Ansible configuration and cache files
echo "Cleaning up Ansible-related files..."
sudo rm -rf /etc/ansible
sudo rm -rf ~/.ansible

# Verify Ansible removal
if ! command -v ansible &> /dev/null; then
  echo "Ansible has been successfully uninstalled."
else
  echo "Ansible is still present. Please check manually."
fi

# Display completion message
echo "Ansible uninstallation complete!"

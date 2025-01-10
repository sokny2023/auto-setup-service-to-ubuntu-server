#!/bin/bash

# Exit script on error
set -e

# Stop Jenkins service
echo "Stopping Jenkins service..."
sudo systemctl stop jenkins
sudo systemctl disable jenkins

# Uninstall Jenkins
echo "Uninstalling Jenkins..."
sudo apt remove --purge -y jenkins
sudo apt autoremove -y
sudo apt autoclean

# Remove Jenkins configuration and data
echo "Removing Jenkins configuration and data..."
sudo rm -rf /var/lib/jenkins
sudo rm -rf /etc/jenkins
sudo rm -rf /var/log/jenkins
sudo rm -rf /usr/share/jenkins
sudo rm -rf /usr/share/doc/jenkins

# Remove Jenkins repository and key
echo "Removing Jenkins repository and key..."
sudo rm -f /etc/apt/sources.list.d/jenkins.list
sudo rm -f /usr/share/keyrings/jenkins-keyring.asc

# Check if Jenkins is fully removed
if ! command -v jenkins &> /dev/null; then
  echo "Jenkins has been successfully uninstalled."
else
  echo "Jenkins is still present. Please check manually."
fi

# Optionally close the firewall port used by Jenkins (8080)
echo "Closing port 8080 in the firewall..."
sudo ufw delete allow 8080
sudo ufw reload

# Output completion message
echo "Jenkins uninstallation complete!"

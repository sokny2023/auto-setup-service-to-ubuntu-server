#!/bin/bash

# Exit script on error
set -e

# Update package index
echo "Updating package index..."
sudo apt update -y && sudo apt upgrade -y

# Install Java (Jenkins requires Java 17 or newer)
echo "Installing Java..."
sudo apt install -y openjdk-17-jdk

# Set Java 17 as default
echo "Configuring Java 17 as default..."
sudo update-alternatives --set java /usr/lib/jvm/java-17-openjdk-amd64/bin/java

# Verify Java installation
echo "Java version:"
java -version

# Add Jenkins repository key
echo "Adding Jenkins repository key..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

# Add Jenkins repository
echo "Adding Jenkins repository..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package index and install Jenkins
echo "Installing Jenkins..."
sudo apt update -y
sudo apt install -y jenkins

# Set Java 17 for Jenkins explicitly
echo "Configuring Jenkins to use Java 17..."
sudo sed -i 's|^JAVA=.*|JAVA=/usr/lib/jvm/java-17-openjdk-amd64/bin/java|' /etc/default/jenkins

# Start and enable Jenkins service
echo "Starting and enabling Jenkins service..."
sudo systemctl daemon-reload
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Open port 8080 for Jenkins in the firewall
echo "Configuring firewall for Jenkins (port 8080)..."
sudo ufw allow 8080
sudo ufw reload

# Retrieve public IP
PUBLIC_IP=$(curl -s ifconfig.me)

# Display Jenkins initial admin password
echo "Jenkins installation complete. Initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword

# Display access information
echo "Access Jenkins at: http://$PUBLIC_IP:8080"

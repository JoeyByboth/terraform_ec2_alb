#!/bin/bash

# Update the package list and upgrade any existing packages
sudo apt-get update
sudo apt-get -y upgrade

# Install Nginx
sudo apt-get -y install nginx

# Start Nginx service
sudo systemctl start nginx

# Fetch instance's public IP and Availability Zone from EC2 metadata
REGION_AZ=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)

# Create a simple HTML page
echo "<!DOCTYPE html>
<html>
<head>
    <title>Hello World</title>
</head>
<body>
    <h1>Hello World!</h1>
    <p>AWS Region/AZ: $REGION_AZ</p>
</body>
</html>" | sudo tee /var/www/html/index.html

# Restart Nginx to serve the new page
sudo systemctl restart nginx
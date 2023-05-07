#!/bin/bash

# Update package list
sudo apt-get update

# Install Apache HTTP server
sudo apt-get install -y apache2

# Create directory for web page
sudo mkdir -p /var/www/html

# Create index.html file with sample content
sudo echo "<html><body><h1>Simple Web Server!</h1></body></html>" > /var/www/html/index.html

# Restart Apache server
sudo systemctl restart apache2

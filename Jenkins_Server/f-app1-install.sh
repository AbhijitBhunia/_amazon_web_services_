#! /bin/bash
# Instance Identity Metadata Reference - https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-identity-documents.html

sudo apt update -y

sudo apt install openjdk-11-jre -y
java -version >> /opt/installation_status.txt

#Jenkins installation
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt update
wget https://get.jenkins.io/war-stable/latest/jenkins.war
java -jar jenkins.war

# Start Jenkins and wait for it to become available
sudo systemctl start jenkins
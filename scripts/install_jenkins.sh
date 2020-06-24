#!bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install default-jdk -y

# add the repo key to the system
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

# append the Debian package repo address to the server's sources.list
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list'

sudo add-apt-repository universe
sudo apt update

sudo apt-get install jenkins -y

sudo systemctl status jenkins

# all following steps must be done manually
#!bin/bash
sudo apt update
sudo apt upgrade -y
sudo apt install default-jdk -y

#issue with pub GPG jenkins key 
#https://knowledge.udacity.com/questions/139443
#https://askubuntu.com/questions/660599/i-am-installing-jenkins-server-but-its-giving-w-gpg-error

# add the repo key to the system
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

# append the Debian package repo address to the server's sources.list
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list'

sudo add-apt-repository universe
sudo apt update

sudo apt-get install jenkins -y

sudo systemctl status jenkins

# optional 
    # Start the Jenkins server
    sudo systemctl start jenkins
    
    # Enable the service to load during boot
    sudo systemctl enable jenkins
# all following steps must be done manually, like unlocking jenkins, installing packages etc.

sudo vim /var/lib/jenkins/secrets/initialAdminPassword #copy initial jenkins password


#!bin/bash

# source: https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04

# update your existing list of packages
sudo apt update

# install a few prerequisite packages which let apt use packages over HTTPS
sudo apt install apt-transport-https ca-certificates curl software-properties-common

# add the GPG key for the official Docker repository to your system
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# add the Docker repository to APT sources:
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

# update the package database with the Docker packages from the newly added repo
sudo apt update

# make sure you are about to install from the Docker repo instead of the default Ubuntu repo, verify if there is candidate
apt-cache policy docker-ce

# install Docker
sudo apt install docker-ce

# verify service running 
sudo systemctl status docker

# to avoid typing sudo whenever you run the docker command, add your username to the docker group
sudo usermod -aG docker ${USER}
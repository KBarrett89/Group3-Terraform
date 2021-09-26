#! /bin/sh

sudo apt update
sudo apt install -y docker.io
sudo useradd -m -s /bin/bash jenkins
sudo usermod -aG docker jenins
sudo su - jenkins
docker swarm init

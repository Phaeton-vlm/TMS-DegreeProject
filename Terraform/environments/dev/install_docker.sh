#!/bin/bash
sudo apt update -y
sudo apt install apt-transport-https ca-certificates curl software-properties-common\ -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - 
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
sudo apt update -y
sudo apt install docker-ce -y

sudo apt-get update -y
sudo apt-get install docker-compose-plugin -y

sudo mkdir -p /home/ubuntu/jenkins/casc_configs
cd /home/ubuntu/jenkins/casc_configs
curl -O https://raw.githubusercontent.com/Phaeton-vlm/TMS-DegreeProject/main/jenkins/casc_configs/jenkins.yaml
curl -O https://raw.githubusercontent.com/Phaeton-vlm/TMS-DegreeProject/main/jenkins/casc_configs/cloud_docker.yaml

cd /home/ubuntu/
curl -O https://raw.githubusercontent.com/Phaeton-vlm/TMS-DegreeProject/main/jenkins/.env
curl -O https://raw.githubusercontent.com/Phaeton-vlm/TMS-DegreeProject/main/jenkins/docker-compose.yaml

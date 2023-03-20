sudo apt-get update -y
sudo apt install openjdk-11-jre-headless -y

#Jenkins

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'  
sudo apt-get update -y
sudo apt-get install jenkins -y

sudo cat /var/lib/jenkins/secrets/initialAdminPassword


sudo vi /etc/sudoers 
jenkins ALL=(ALL) NOPASSWD: ALL 
sudo su - jenkins  


#Docker 

sudo apt install docker.io -y
sudo usermod -aG docker jenkins 

#AWS CLI

sudo apt install awscli 
aws configure

#Install and Setup Kubectl

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl 
sudo mv ./kubectl /usr/local/bin


#Install and Setup eksctl

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin 

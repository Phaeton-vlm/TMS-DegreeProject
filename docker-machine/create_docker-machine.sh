#! /bin/env bash
source ./set_cred_env.sh

export MACHINE_NAME="vlm-jenkins-server"
export SYNC_FOLDER="jenkins"
export MACHINE_USER="ubuntu"
export ROOT_DIR="/mnt/e/DevOps/TMS-DegreeProject/TMS-DegreeProject"

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
red="$( echo -e '\033[0;31m' )" # Red
grn="$( echo -e '\033[0;32m' )" # Green
lcn="$( echo -e '\033[1;36m' )" # Light Cyan 
rst="$( echo -e '\033[0m' )"    # Reset Color format

echo -e $grn"\nCreating machine..."$rst
docker-machine create \
	--driver amazonec2 \
	--amazonec2-vpc-id vpc-042884a1f4f1e3b08 \
	--amazonec2-region us-east-1 \
	--amazonec2-ami ami-09cd747c78a9add63 \
	--amazonec2-instance-type t2.medium \
	--amazonec2-open-port 8080 \
"$MACHINE_NAME"

echo -e $grn"\nCreating sync folder..."$rst
cd "$ROOT_DIR"
docker-machine ssh "$MACHINE_NAME" mkdir "$SYNC_FOLDER"
docker-machine scp -r ./"$SYNC_FOLDER/" "$MACHINE_NAME":"/home/$MACHINE_USER/"
cd "$CWD"

echo -e $grn"\nCoping ssh key for github..."$rst
docker-machine scp ./ssh_key/id_rsa "$MACHINE_NAME":"/home/$MACHINE_USER/.ssh/id_rsa"
docker-machine ssh "$MACHINE_NAME" "chmod 400 /home/"$MACHINE_USER"/.ssh/id_rsa"

echo -e $grn"\nCoping access token for dockerhub..."$rst
docker-machine scp ./ssh_key/docker_token "$MACHINE_NAME":"/home/$MACHINE_USER/.ssh/dockerhub_token"
docker-machine ssh "$MACHINE_NAME" "chmod 400 /home/"$MACHINE_USER"/.ssh/dockerhub_token"

echo -e $grn"\nCoping access token for Email..."$rst
docker-machine scp ./email_cred/app_password "$MACHINE_NAME":"/home/$MACHINE_USER/.ssh/app_password"
docker-machine ssh "$MACHINE_NAME" "chmod 400 /home/"$MACHINE_USER"/.ssh/app_password"

echo -e $grn"\nCoping aws cred..."$rst
[ -d ./aws_cred ] || mkdir ./aws_cred
docker-machine scp -r ./aws_cred/ "$MACHINE_NAME":"/home/$MACHINE_USER/.aws_cred/"

echo -e $grn"\nActivating machine.."$rst
eval $(docker-machine env vlm-jenkins-server)

cd ../jenkins
docker compose up -d

echo -e "Your Jenkins server ip - $lcn$(docker-machine ip "$MACHINE_NAME"):8080"$rst
echo -e "Jenkins login: $lcn$(cat ./.env | grep JENKINS_ADMIN_ID | awk -F '=' '{print $2}')$rst"
echo -e "Jenkins password: $lcn$(cat ./.env | grep JENKINS_ADMIN_PASSWORD | awk -F '=' '{print $2}')$rst"
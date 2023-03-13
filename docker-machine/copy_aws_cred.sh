#! /bin/env bash
source ./set_cred_env.sh

export MACHINE_NAME="vlm-jenkins"
export SYNC_FOLDER="jenkins"
export MACHINE_USER="ubuntu"
export ROOT_DIR="/mnt/e/DevOps/TMS-DegreeProject/TMS-DegreeProject"

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
red="$( echo -e '\033[0;31m' )" # Red
grn="$( echo -e '\033[0;32m' )" # Green
rst="$( echo -e '\033[0m' )"    # Reset Color format

echo -e $grn"\nCoping aws cred..."$rst
[ -d ./aws_cred ] || mkdir ./aws_cred
docker-machine scp -r ./aws_cred/ "$MACHINE_NAME":"/home/$MACHINE_USER/.aws_cred/"
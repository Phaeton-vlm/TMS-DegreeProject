#! /bin/env bash
export MACHINE_NAME="vlm-jenkins-server"
export SYNC_FOLDER="jenkins"
export MACHINE_USER="ubuntu"
export ROOT_DIR="/mnt/e/DevOps/TMS-DegreeProject/TMS-DegreeProject"

CWD="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
red="$( echo -e '\033[0;31m' )" # Red
grn="$( echo -e '\033[0;32m' )" # Green
rst="$( echo -e '\033[0m' )"    # Reset Color format

echo -e $grn"\nSynchronizing folder..."$rst
cd "$ROOT_DIR"
docker-machine scp -r ./"$SYNC_FOLDER/" "$MACHINE_NAME":"/home/$MACHINE_USER/"
cd "$CWD"

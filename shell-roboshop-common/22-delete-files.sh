#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "the script started executed in $(date)"
START_TIME=$(date +%s)

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "Error::run user with root privilizes"
    exit 1
fi

LOG_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f 1) #($(echo $0 | awk -F "-" '{print $1}'))
FILE_NAME=$LOG_FOLDER/$SCRIPT_NAME.log

mkdir -p /var/log/shell-script

SOURCE_DIR="/home/ec2-user/app-logs"
if [ ! -d $SOURCE_DIR ]; then
    echo "Error:: $SOURCE_DIR Directory not exist"
fi

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -type f -mtime +14)

while IFS= read -r filepath #internal field seperator
do 
    echo "files to delete : $filepath"
    
done <<< $FILES_TO_DELETE
#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "Error:: run command with root user privilizes." | tee -a $FILE_NAME
    exit 1
fi

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | awk -F "." '{print $1}')
FILE_NAME="$LOGS_FOLDER/$SCRIPT_NAME.log"
mkdir -p $LOGS_FOLDER

SOURCE_DIR="/home/ec2-user/app-logs"
if [ -d $SOURCE_DIR ]; then
    echo -e "Error:: Source directory doesnot exist"
fi

find $SOURCE_DIR -type f -mtime +14
while IFS= read -r filepath
do
    echo "the files are : $filepath"
done <<< $SOURCE_DIR



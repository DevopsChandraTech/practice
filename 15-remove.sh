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
SCRIPT_NAME=$(echo "$0" | cut -d "." -f 1) #($(echo $0 | awk -F "-" '{print $1}'))
FILE_NAME=$LOG_FOLDER/$SCRIPT_NAME.log

mkdir -p /var/log/shell-script

VALIDATE(){
    if [ $? -ne 0 ]; then
        echo "Error::command not found"
        exit 1
    else 
        echo -e "UnInstalling $2 $G Success..! $N"
    fi
}

dnf list installed mysql 
if [ $? -eq 0 ]; then
    dnf remove mysql -y
    VALIDATE $? "MySql"
else
    echo -e "MySql not installed $Y Skipping..! $N"
fi

dnf list installed nginx
if [ $? -eq 0 ]; then
    dnf remove nginx -y
    VALIDATE $? "Nginx"
else
    echo -e "Nginx not installed $Y Skipping..! $N"
fi

dnf list installed unzip
if [ $? -eq 0 ]; then
    dnf remove unzip -y
    VALIDATE $? "Unzip"
else
    echo -e "Unzip not installed $Y Skipping..! $N"
fi
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

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e "$R Failure $N command not found." | tee -a $FILE_NAME
        exit 1
    else    
        echo -e "$G Success..! $N" | tee -a $FILE_NAME
    fi
}

cp mongo.repo /etc/yum.repos.d/mongo.repo

dnf install mongodb-org -y  &>> $FILE_NAME
VALIDATE $? "Install mongodb"
systemctl enable mongod  &>> $FILE_NAME
VALIDATE $? "Enable mongodb"
systemctl start mongod &>> $FILE_NAME
VALIDATE $? "Start mongodb"
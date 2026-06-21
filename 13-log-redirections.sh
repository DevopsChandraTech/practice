#!/bin/bash

#install mysql nginx pyhton3
#need to check user has root user privilizes or not
#install mysql nginx python3
R="\e[31m"
G="\e[32m"
N="\e[0m"

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "Error:: run command with root user privilizes." &>> $FILE_NAME
    exit 1
else
    echo "Installing $2" &>> $FILE_NAME
fi

LOGS_FOLDER="/var/nginx/shell-script"
SCRIPT_NAME=$(echo $0 | awk -F "." '{print $0}')
FILE_NAME="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e "$2 Installation $R Failure..! $N" &>> $FILE_NAME
        exit 1
    else 
        echo -e "$2 Installation is $G Success..! $N" &>> $FILE_NAME
    fi
}

dnf install mysql -y
VALIDATE $? MySql

dnf install nginx -y
VALIDATE $? Nginx

dnf install python3 -y
VALIDATE $? Python3


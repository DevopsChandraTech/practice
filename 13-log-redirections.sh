#!/bin/bash

#install mysql nginx pyhton3
#need to check user has root user privilizes or not
#install mysql nginx python3
R="\e[31m"
G="\e[32m"
N="\e[0m"

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "Error:: run command with root user privilizes." | tee -a $FILE_NAME
    exit 1
else
    echo "Installing $2" | tee -a $FILE_NAME
fi

LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | awk -F "." '{print $1}')
FILE_NAME="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOGS_FOLDER

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo "$R Failure $N command not found."
    else    
        echo "$G Success $N Installing $2"
    fi
}
#mysql installation

dnf list installed mysql
if [ $? -ne 0 ]; then
    dnf install mysql -y
    VALIDATE $? MySql
else 
    echo "$2 already installed $Y Skipping..! $N"
fi

#nginx installation

dnf list installed mysql
if [ $? -ne 0 ]; then
    dnf install nginx -y
    VALIDATE $? Nginx
else 
    echo "$2 already installed $Y Skipping..! $N"
fi

#Python3 Installation

dnf list installed mysql
if [ $? -ne 0 ]; then
    dnf install python3 -y
    VALIDATE $? Python3
else 
    echo "$2 already installed $Y Skipping..! $N"
fi



#!/bin/bash

#install mysql nginx pyhton3
#need to check user has root user privilizes or not
#install mysql nginx python3
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
        echo -e "$G Success $N Installing $2" | tee -a $FILE_NAME
    fi
}

#installations
for package in $@
do
    dnf list installed $package &>> $FILE_NAME
    if [ $? -ne 0 ]; then
        dnf install $package -y &>> $FILE_NAME
        VALIDATE $? "$package"
    else    
        echo -e "$package already installed $Y Skipping...! $N" | tee -a $FILE_NAME
    fi
done
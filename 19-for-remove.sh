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

VALIDATE(){
    if [ $? -ne 0 ]; then
        echo "Error::command not found" | tee -a $FILE_NAME
        exit 1
    else 
        echo -e "Installing $2 $G Success..! $N" | tee -a $FILE_NAME
    fi
}

for package in $@;
do 
    dnf list installed $package &>> $FILE_NAME
    if [ $? -eq 0 ]; then
        dnf remove $package -y &>> $FILE_NAME
        VALIDATE $? $package
    else 
        echo -e "$package not installed $Y Skipping..! $N" | tee -a $FILE_NAME
    fi

done
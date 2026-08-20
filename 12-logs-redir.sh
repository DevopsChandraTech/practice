#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "the script started and executed at $(date)"
USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "Error:: run user with root user privilizes" | tee -a $LOG_FILE
    exit 1
fi

LOG_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | awk -F "." '{print $1}')
LOG_FILE="$LOG_FOLDER/$SCRIPT_NAME.log"

mkdir -p $LOG_FOLDER

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e "Installing $2 is $R Failure..! $N"  | tee -a $LOG_FILE
        exit 1
    else 
        echo -e "Installing $2 is $G Success..! $N" | tee -a $LOG_FILE
    fi
}

dnf list installed mysql &>> $LOG_FILE
if [ $? -ne 0 ]; then
    dnf install mysql -y &>> $LOG_FILE
    VALIDATE $? MySql
else
    echo -e "MySql already Installed $Y Skipping..! $N" | tee -a $LOG_FILE
fi

dnf list installed nginx &>> $LOG_FILE
if [ $? -ne 0 ]; then
    dnf install nginx -y &>> $LOG_FILE
    VALIDATE $? Nginx
else
    echo -e "Nginx already Installed $Y Skipping..! $N" | tee -a $LOG_FILE
fi

dnf list installed unzip &>> $LOG_FILE
if [ $? -ne 0 ]; then
    dnf install unzip -y &>> $LOG_FILE
    VALIDATE $? Unzip
else
    echo -e "Unzip already Installed $Y Skipping..! $N" | tee -a $LOG_FILE
fi


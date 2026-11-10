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
LOG_FILE=$LOG_FOLDER/$SCRIPT_NAME.log

mkdir -p /var/log/shell-script

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo "Error::command not found" | tee -a $LOG_FILE
        exit 1
    else 
        echo -e "Installing $2 $G Success..! $N" | tee -a $LOG_FILE
    fi
}

dnf install mysql-server -y &>> $LOG_FILE
VALIDATE $? "Install MySql"
systemctl enable mysqld &>> $LOG_FILE
VALIDATE $? "Enable MySql"
systemctl start mysqld &>> $LOG_FILE
VALIDATE $? "Start MySql" 
mysql_secure_installation --set-root-pass RoboShop@1 &>> $LOG_FILE
VALIDATE $? "Setting Rootpassword" 
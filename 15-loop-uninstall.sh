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
        echo -e "Uninstalling $2 is $G Success..! $N" | tee -a $LOG_FILE
    fi
}

for package in $@;
do
   dnf list installed $package &>> $LOG_FILE
    if [ $? -eq 0 ]; then
        dnf remove $package -y &>> $LOG_FILE
        VALIDATE $? $package
    else
        echo -e "$package already Removed $Y Skipping..! $N" | tee -a $LOG_FILE
    fi 
done
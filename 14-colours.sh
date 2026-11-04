#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

START_TIME=$(date +%s)
echo "the script started executed at $date"
USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "run user with root privilizes"
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo "Installing $2 is $G Success...! $N"
    else
        echo "$2 already installed $Y Skipping..! $N"
    fi
}

dnf list installed mysql 
VALIDATE $? "MySql"

dnf list installed nginx
VALIDATE $? "Nginx"

dnf list installed unzip
VALIDATE $? "Unzip"

END_TIME=$(date +%s)
TOTAL_TIME=$($END_TIME - $START_TIME)
echo "the script executed in $TOTAL_TIME Secs."
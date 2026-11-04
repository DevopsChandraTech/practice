#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "the script started executed in $date"
START_TIME=$(date +%s)

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "Error::run user with root privilizes"
    exit 1
fi

VALIDATE(){
    if [ $? -ne 0 ]; then
        echo "Error::command not found"
        exit 1
    else 
        echo -e "Installing $2 $G Success..! $N"
    fi
}

dnf list installed mysql 
if [ $? -ne 0 ]; then
    dnf install mysql -y
    VALIDATE $? "MySql"
else 
    echo -e "MySql already Installed $Y Skipping...! $N"
fi

dnf list installed nginx 
if [ $? -ne 0 ]; then
    dnf install nginx -y
    VALIDATE $? "Nginx"
else 
    echo -e "Nginx already Installed $Y Skipping...! $N"
fi

dnf list installed unzip
if [ $? -ne 0 ]; then
    dnf install unzip -y
    VALIDATE $? "Unzip"
else 
    echo -e "Unzip already Installed $Y Skipping...! $N"
fi

END_TIME=$(date +%s)
TOTAL_TIME=$(($END_TIME - $START_TIME))
echo -e "the script executed in $Y $TOTAL_TIME $N Secs."





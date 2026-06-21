#!/bin/bash

#install mysql nginx pyhton3
#need to check user has root user privilizes or not
#install mysql nginx python3
R="\e[31m"
G="\e[32m"
N="\e[0m"

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "Error:: run command with root user privilizes."
else
    echo "Installing MySql"
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo "$2 Installation $R Failure..! $N"
    else 
        echo "$2 Installation is $G Success..! $N"
    fi
}

dnf install mysql -y
VALIDATE $? MySql

dnf install nginx -y
VALIDATE $? Nginx

dnf install python3
VALIDATE $? Python3


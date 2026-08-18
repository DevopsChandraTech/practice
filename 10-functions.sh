#!/bin/bash

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "Error:: run user with root user privilizes"
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo "Error:: Installing $2 is Failure"
    else 
        echo "Installing $2 is Success."
    fi
}

dnf install mysql -y
VALIDATE $? MySql

dnf install nginx -y
VALIDATE $? Nginx

dnf install unzip -y
VALIDATE $? Unzip
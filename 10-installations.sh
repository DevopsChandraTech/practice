#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "Error:: run comand with root user privilizes"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then # functions taken variables as arguments like shell script arguments
        echo "Error:: Installing $2 is Failure..!"
        exit 1
    else
        echo "Installing $2 is Success..!"
    fi
}

#mysql installation
dnf list installed mysql 
VALIDATE $? "MySql"

#nginx installation
dnf install nginx -y
VALIDATE $? "Nginx"

#unzip installation
dnf install unzip -y
VALIDATE $? "Unzip"



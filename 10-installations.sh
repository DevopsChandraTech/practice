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
if [ $? -ne 0 ]; then
    dnf install mysql -y
    exit 1
else 
    echo "MySQl already installed Skipping...!"
fi
VALIDATE $? "MySql"

#nginx installation
dnf list installed nginx 
if [ $? -ne 0 ]; then
    dnf install nginx -y
    exit 1
else 
    echo "Nginx already installed Skipping...!"
fi
VALIDATE $? "Nginx"

#unzip installation
dnf list installed unzip
if [ $? -ne 0 ]; then
    dnf install unzip -y
    exit 1
else 
    echo "Unzip already installed Skipping...!"
fi
VALIDATE $? "Unzip"



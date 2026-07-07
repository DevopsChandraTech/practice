#!/bin/bash

USERID=$(id -u)

# checking root user access
if [ $USERID -ne 0 ]; then
    echo "Error:: Run command with root user privilizes."
    exit 1
fi

# checking command is correct or not
VALIDATE(){
    if [ $1 -ne 0 ]; then # functions take inputs as args like shell script args
        echo "Error:: Unable to find the command."
        exit 1
    else 
        echo "Success::Installing the $2"
    fi
}

#mysql installation
dnf install mysql -y
VALIDATE $? "MySql"
if [ $? -ne 0 ]; then
    echo "Error:: MySql Installation is fail"
    exit 1
else
    echo "MySql Installation is Success."
fi

#nginx installation
dnf install nginx -y
VALIDATE $? "Nginx"
if [ $? -ne 0 ]; then
    echo "Error:: Nginx Installation is fail"
    exit 1
else
    echo "Nginx Installation is Success."
fi

#python3 installation
dnf install python3 -y
VALIDATE $? "Python3"
if [ $? -ne 0 ]; then
    echo "Error:: Python3 Installation is fail"
    exit 1
else
    echo "Python3 Installation is Success."
fi
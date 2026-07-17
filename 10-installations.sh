#!/bin/bash

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "Error:: run comand with root user privilizes"
    exit 1
fi

#mysql installation
dnf install mysql -y
if [ $? -ne 0 ]; then
    echo "Error:: Installing MySql is Failure..!"
    exit 1
else
    echo "Installing MySql is Success..!"
fi

#nginx installation
dnf install nginx -y
if [ $? -ne 0 ]; then
    echo "Error:: Installing nginx is Failure..!"
    exit 1
else
    echo "Installing nginx is Success..!"
fi

#unzip installation
dnf install unzip -y
if [ $? -ne 0 ]; then
    echo "Error:: Installing Unzip is Failure..!"
    exit 1
else
    echo "Installing Unzip is Success..!"
fi



#!/bin/bash

# check user has root user privilizes
USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "check user root privilizes"
fi

dnf install mysql -y

if [ $? -ne 0 ]; then
    echo "Error::check once the command"
else 
    echo "Installing MySql Success..!"
fi

dnf install nginx -y

if [ $? -ne 0 ]; then
    echo "Error::check once the command"
else 
    echo "Installing Nginx Success..!"
fi

dnf install unzip -y

if [ $? -ne 0 ]; then
    echo "Error::check once the command"
else 
    echo "Installing Unzip Success..!"
fi
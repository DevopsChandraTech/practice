#!/bin/bash

# installing mysql nginx unzip into linux machine
# check user has root access or not
# check all above softwares already installed or not
# if installed showing error otherwise need to install

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "Error:: check user has root privilizes or not"
fi

dnf install mysql -y
if [ $? -ne 0 ]; then
    echo "Installing MySql is Success...!"
else 
    echo "MySql already installed Skipping...!"
fi

dnf install nginx -y
if [ $? -ne 0 ]; then
    echo "Installing Nginx is Success...!"
else 
    echo "Nginx already installed Skipping...!"
fi

dnf install unzip -y
if [ $? -ne 0 ]; then
    echo "Installing Unzip is Success...!"
else 
    echo "Unzip already installed Skipping...!"
fi


#!/bin/bash

USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
    echo "Error:: run command with root user privilizes"
fi

#Installing MySql
dnf install mysql -y
if [ $? -ne 0 ]; then
    echo "Error:: command not found"
else 
    echo "Success:: Installing MySql"
fi

#Installing Nginx
dnf install nginx -y
if [ $? -ne 0 ]; then
    echo "Error:: command not found"
else
    echo "Success:: Installing MySql"
fi

#Installing Unzip
dnf install unzip -y
if [ $? -ne 0 ]; then
    echo "Error:: command not found"
else 
    echo "Success:: Installing MySql"
fi

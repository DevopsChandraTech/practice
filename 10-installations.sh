#!/bin/bash

USERID=$(id -u)

# checking root user access
if [ $USERID -ne 0 ]; then
    echo "Error:: Run command with root user privilizes."
    exit 1
fi

# checking command is correct or not
if [ $? -ne 0 ]; then
    echo "Error:: Unable to find the command."
    exit 1
else 
    echo "Success::Installing the mysql"
fi

#mysql installation
dnf install mysql -y
if [ $? -ne 0 ]; then
    echo "Error:: MySql Installation is fail"
    exit 1
else
    echo "MySql Installation is Success."
fi

#nginx installation
if [ $? -ne 0 ]; then
    echo "Error:: Unable to find the command."
    exit 1
else 
    echo "Success::Installing the nginx"
fi

dnf install nginx -y
if [ $? -ne 0 ]; then
    echo "Error:: Nginx Installation is fail"
    exit 1
else
    echo "Nginx Installation is Success."
fi

#python3 installation
if [ $? -ne 0 ]; then
    echo "Error:: Unable to find the command."
    exit 1
else 
    echo "Success::Installing the python3"
fi

dnf install python3 -y
if [ $? -ne 0 ]; then
    echo "Error:: Python3 Installation is fail"
    exit 1
else
    echo "Python3 Installation is Success."
fi


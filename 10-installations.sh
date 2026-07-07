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

dnf install mysql -y
if [ $? -ne 0 ]; then
    echo "Error:: MySql Installation is fail"
    exit 1
else
    echo "MySql Installation is Success."
fi



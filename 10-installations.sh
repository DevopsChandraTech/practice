#!/bin/bash

USERID=$(id -u)

# checking root user access
if [ $USERID -ne 0 ]; then
    echo "Error:: Run command with root user privilizes."
fi

# checking command is correct or not
if [ $? -ne 0 ]; then
    echo "Error:: Unable to find the command."
else 
    echo "Success::Installing the mysql"
fi

dnf install mysql -y
if [ $? -ne 0 ]; then
    echo "Error:: MySql Installation is fail"
else
    echo "MySql Installation is Success."
fi



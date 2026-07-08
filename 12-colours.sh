#!/bin/bash

R="\e[31e"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


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

#mysql installation:
dnf list installed mysql 
if [ $? -ne 0 ]; then
    dnf install mysql -y
    VALIDATE $? "Installing MySql"
    exit 1
else    
    echo "$2 already installed $Y Skipping..! $N"
fi



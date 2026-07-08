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
        echo "Installing $2 is $R Failure..! $N."
        exit 1
    else 
        echo -e "$2 Installation is $G Success..! $Y"
    fi
}

#mysql installation:
dnf list installed mysql 
if [ $? -ne 0 ]; then
    dnf install mysql -y
    VALIDATE $? MySql
else    
    echo -e "$2 already installed $Y Skipping..! $N"
fi

#nginx installation
dnf list installed nginx
if [ $? -ne 0 ]; then
    dnf install nginx -y
    VALIDATE $? Nginx
else    
    echo -e "$2 already installed $Y Skipping..! $N"
fi

#python3 installation 
dnf list installed python3
if [ $? -ne 0 ]; then
    dnf install python3 -y
    VALIDATE $? Python3
else    
    echo -e "$2 already installed $Y Skipping..! $N"
fi



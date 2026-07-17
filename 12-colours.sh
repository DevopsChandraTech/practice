#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)
if [ $USERID -ne 0 ]; then
    echo "Error:: run comand with root user privilizes"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then # functions taken variables as arguments like shell script arguments
        echo -e "Error:: Installing $2 is $R Failure..! $N"
        exit 1
    else
        echo -e "$2 Installation is $G Success..! $N"
    fi
}

#mysql installation
dnf list installed mysql 
if [ $? -ne 0 ]; then
    dnf install mysql -y
    VALIDATE $? "MySql"
else 
    echo -e "MySQl already installed $Y Skipping...! $N"
fi


#nginx installation
dnf list installed nginx 
if [ $? -ne 0 ]; then
    dnf install nginx -y
    VALIDATE $? "Nginx"
else 
    echo -e "Nginx already installed $Y Skipping...! $N"
fi


#unzip installation
dnf list installed unzip
if [ $? -ne 0 ]; then
    dnf install unzip -y
    VALIDATE $? "Unzip"
else 
    echo -e "Unzip already installed $Y Skipping...! $N"
fi
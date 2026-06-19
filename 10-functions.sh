#!/bin/bash

#install mysql on server
#mysql installation:
# 1.check user has root privilizes or not
# 2.check command is correct or not
# 3.install mysql 

# check user has root privilizes or not
START_TIME=$(date +%s)

USER_ID=$(id -u)

if [ $USER_ID -ne 0 ]; then
    echo "Error:: run command with root user privilizes."
    exit 1
else 
    echo "Success:: Installing MySql."
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then # functions take inputs as a arguments like shell-script arguments
        echo "Error:: please check once the command"
        exit 1
    else 
        echo "$2 Installed Successfully."
    fi
}

#mysql installation
dnf install mysql -y
VALIDATE $? MySql

#nginx installation
dnf install nginx -y
VALIDATE $? Nginx

#python3 installation
dnf install python3 -y
VALIDATE $? Python3

END_TIME=$(date +%s)

TOTAL_TIME=$(($END_TIME-$START_TIME))

echo "the script executed in $TOTAL_TIME Secs."
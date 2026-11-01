#!/bin/bash

USER_ID=$(id -u)

if [ $? -ne 0 ]; then
    echo "run command with root user privilizes"
fi

# I need to install MySql Nginx and Unzip to the server through shell script
# check first user has root user access or not
# if had the access then install

# check mysql already exist or not if exist skip if not then proceed with installation
VALIDATE(){ #functions take inputs like args like shell script args
   if [ $1 -ne 0 ]; then
        echo "Installing the $2 Success..!"
   elif 
        echo "$2 already Installed Skipping..!"
   fi 
}

dnf list installed mysql
VALIDATE $? "MySql"

dnf list installed nginx
VALIDATE $? "Nginx"

dnf list installed unzip
VALIDATE $? "Unzip"


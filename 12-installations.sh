#!/bin/bash

USER_ID=$(id -u)

if [ $? -ne 0 ]; then
    echo "run command with root user privilizes"
fi

# I need to install MySql Nginx and Unzip to the server through shell script
# check first user has root user access or not
# if had the access then install

# check mysql already exist or not if exist skip if not then proceed with installation
dnf install mysql -y
if [ $? -ne 0 ]; then
    echo "Installing the MySql Success..!"
elif 
    echo "MySql already Installed Skipping..!"
fi

dnf install nginx -y
if [ $? -ne 0 ]; then
    echo "Installing the Nginx Success..!"
elif 
    echo "Nginx already Installed Skipping..!"
fi

dnf install unzip -y
if [ $? -ne 0 ]; then
    echo "Installing the Unzip Success..!"
elif 
    echo "Unzip already Installed Skipping..!"
fi




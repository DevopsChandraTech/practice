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
else 
    echo "Success:: Installing MySql."
fi

dnf install mysql -y

if [ $? -ne 0 ]; then
    echo "Error:: please check once the command"
else 
    echo "MySql Successfully Installed."
fi

END_TIME=$(date +%s)

TOTAL_TIME=$(($END_TIME-$START_TIME))

echo "the script executed in $TOTAL_TIME Secs."
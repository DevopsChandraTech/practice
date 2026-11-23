#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "the script started executed in $(date)"
START_TIME=$(date +%s)

USER_ID=$(id -u)
SOURCE_DIR=$1
DEST_DIR=$2

if [ $USER_ID -ne 0 ]; then
    echo "Error::run user with root privilizes"
    exit 1
fi

LOG_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f 1) #($(echo $0 | awk -F "-" '{print $1}'))
FILE_NAME=$LOG_FOLDER/$SCRIPT_NAME.log

mkdir -p /var/log/shell-script

USAGE(){
    echo -e "$R sudo sh 23-delete-logs.sh <SOURCE_DIR> <DEST_DIR> <DAYS>[optional default 14days] $N"
}

if [ $# -le 2 ]; then
    USAGE
fi

if [ ! -d $SOURCE_DIR ]; then
    echo "source directory doesnot exist"
fi

if [ ! -d $DEST_DIR ]; then
    echo "destination directory doesnot exist"
fi

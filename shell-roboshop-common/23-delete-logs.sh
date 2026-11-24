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
DAYS=${3:-14} # if not provided default is 14 days taken

if [ $USER_ID -ne 0 ]; then
    echo "Error::run user with root privilizes"
    exit 1
fi

LOG_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f 1) #($(echo $0 | awk -F "-" '{print $1}'))
FILE_NAME=$LOG_FOLDER/$SCRIPT_NAME.log

mkdir -p /var/log/shell-script
### check the usage given same format or not ###
USAGE(){
    echo -e "$R sudo sh 23-delete-logs.sh <SOURCE_DIR> <DEST_DIR> <DAYS>[optional default 14days] $N"
    exit 1
}
### check 2 arguments received or not
if [ $# -lt 2 ]; then
    USAGE
fi
### check sour-dir exist or not ###
if [ ! -d $SOURCE_DIR ]; then
    echo "source directory doesnot exist"
    exit 1
fi

### check dest-dir exist or not ###
if [ ! -d $DEST_DIR ]; then
    echo "destination directory doesnot exist"
    exit 1
fi
### find the files from sour directory ###
FILES=$(find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS)

### check directory empty or not ###
if [ ! -z "${FILES}" ]; then
    echo "files found $FILES"
    TIME_STAMP=$(date +%F-%H-%M)
    ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIME_STAMP.zip" 
    echo "zip file name is : $ZIP_FILE_NAME"
    find $SOURCE_DIR -name "*.log" -type f -mtime +$DAYS | zip -@ -j "$ZIP_FILE_NAME"
    ### check arichval success or not ###
    if [ -f $ZIP_FILE_NAME ]; then
        echo -e "Archival $G Success..! $N"
        while IFS= read -r filepath
        do 
            echo "deleting the file $filepath"
            rm -rf $filepath
            echo "deleted the file $filepath"
        done <<< $FILES
    else
        echo -e "Archival $R Failure..! $N"
    fi

else
    echo -e "source directory empty $Y Skipping $N"
fi

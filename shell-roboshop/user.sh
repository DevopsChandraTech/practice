#!/bin/bash
#colours 
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USER_ID=$(id -u)
#checking root user privilizes
if [ $USER_ID -ne 0 ]; then
    echo "Error:: run command with root user privilizes"
fi

#print script execution time
START_TIME=$(date +%s)
echo "the script started executed by $(date)"

LOG_FOLDER="/var/log/shell-script"
FILE_NAME=$(echo "$0" | cut -d "." -f 1)
LOG_FILE=$LOG_FOLDER/$FILE_NAME.log
SCRIPT_DIR=$PWD
MONGODB_HOST="mongodb.techaws.shop"

mkdir -p $LOG_FOLDER

VALIDATE (){
    if [ $1 -ne 0 ]; then
        echo -e "Error:: $R $2 $N Command Not Found." | tee -a $LOG_FILE
        exit 1
    else    
        echo -e "$2 $G Success $N" | tee -a $LOG_FILE
    fi
}

# installing nginx server
dnf module disable nodejs -y &>> $LOG_FILE
dnf module enable nodejs:20 -y &>> $LOG_FILE
dnf install nodejs -y &>> $LOG_FILE
VALIDATE $? "Installing nodejs"
# create systemuser
id roboshop &>> $LOG_FILE
if [ $? -ne 0 ]; then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
    VALIDATE $? "Create System User"
else
    echo -e "User already exist $Y Skipping..! $N"
fi
# download and install dependencies
mkdir -p /app &>> $LOG_FILE
cd /app
curl -L -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user-v3.zip &>> $LOG_FILE
rm -rf /app/*
unzip /tmp/user.zip &>> $LOG_FILE
npm install &>> $LOG_FILE
VALIDATE $? "Install Dependencies"
# create custom systemservice
cp $SCRIPT_DIR/user.service /etc/systemd/system/user.service &>> $LOG_FILE
systemctl daemon-reload
systemctl enable user &>> $LOG_FILE
systemctl start user &>> $LOG_FILE
VALIDATE $? "Create System Service"

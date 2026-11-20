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

#installing nodejs application
dnf module disable nodejs -y &>> $LOG_FILE
dnf module enable nodejs:20 -y &>> $LOG_FILE
dnf install nodejs -y &>> $LOG_FILE
VALIDATE $? "Installing NodeJS"

# the script runs many time but the comes with the same result is called idompotant
# here we run again the script "coming user already exist error" this is not idompotant
id roboshop &>> $LOG_FILE # checks the roboshop pid exist or not
if [ $? -ne 0 ]; then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>> $LOG_FILE
else
    echo -e "User already exists $Y Skipping..! $N" &>> $LOG_FILE
fi
VALIDATE $? "Creating System User"

# Installing Dependencies
mkdir -p /app &>> $LOG_FILE
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>> $LOG_FILE
cd /app &>> $LOG_FILE
rm -rf /app/*
unzip /tmp/catalogue.zip &>> $LOG_FILE
npm install &>> $LOG_FILE
VALIDATE $? "Installing Dependencies"

# Creating System Service
cp $SCRIPT_DIR/catalogue.service /etc/systemd/system/catalogue.service &>> $LOG_FILE
systemctl daemon-reload &>> $LOG_FILE
systemctl enable catalogue &>> $LOG_FILE
systemctl start catalogue &>> $LOG_FILE
VALIDATE $? "Start Catalogue Service"

# Installing MongoDB Client
cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOG_FILE
dnf install mongodb-mongosh -y &>> $LOG_FILE
VALIDATE $? "Installing MongoDB Clint"

# Loading Catalogue Products
INDEX=$(mongosh mongodb.techaws.shop --quiet --eval "db.getMongo().getDBNames().indexOf('catalogue')") &>> $LOG_FILE
if [ $INDEX -le 1 ]; then
    mongosh --host $MONGODB_HOST < /app/db/master-data.js &>> $LOG_FILE
    VALIDATE $? "Load catalogue products"
else
    echo -e "Catalogue Products already exist $Y Skipping..! $N" &>> $LOG_FILE
fi

systemctl restart catalogue
VALIDATE $? "Restart Catalogue Service"
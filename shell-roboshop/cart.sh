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

# Installing NodeJS
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
VALIDATE $? "Installing NodeJS"
#Starting Service
systemctl daemon-reload
systemctl enable nodejs
systemctl start nodejs
VALIDATE $? "Starting NodeJS Service"
#creating system user
id roboshop 
if [ $? -ne 0 ]; then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
    VALIDATE $? "Adding User"
else
    echo "System User already Exist $Y Skipping..! $N"
fi

# Installing Dependencies
rm -rf /app
mkdir -p /app
curl -L -o /tmp/cart.zip https://roboshop-artifacts.s3.amazonaws.com/cart-v3.zip
cd /app
unzip /tmp/cart.zip
npm install
# Creating System Service
cp $SCRIPT_DIR/cart.service /etc/systemd/system/cart.service
systemctl daemon-reload
systemctl enable cart.service
systemctl start service
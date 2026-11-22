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

# install python
dnf install python3 gcc python3-devel -y &>> $LOG_FILE
VALIDATE $? "Installing Python"
# creating user
id roboshop &>> $LOG_FILE
if [ $? -ne 0 ]; then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>> $LOG_FILE
    VALIDATE $? "Creating User"
else 
    echo -e "User already exists $Y Skipping $N"
fi

# download code
mkdir -p /app
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment-v3.zip &>> $LOG_FILE
cd /app 
rm -rf /app/* &>> $LOG_FILE
unzip /tmp/payment.zip &>> $LOG_FILE
VALIDATE $? "Downloading Code"
# installing dependencies
cd /app
pip3 install -r requirements.txt &>> $LOG_FILE
VALIDATE $? "Installing Dependencies"
# create and start systemservice
cp $SCRIPT_DIR/payment.service /etc/systemd/system/payment.service &>> $LOG_FILE
systemctl daemon-reload
systemctl enable payment &>> $LOG_FILE
systemctl start payment &>> $LOG_FILE
VALIDATE $? "Start Payment Service"

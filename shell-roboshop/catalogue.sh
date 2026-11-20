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
echo "the script started executed by $date"

LOG_FOLDER="/var/log/shell-script"
FILE_NAME=$(echo "$0" | cut -d "." -f 1)
LOG_FILE=$LOG_FOLDER/$FILE_NAME.log
SCRIPT_DIR=$PWD

mkdir -p $LOG_FOLDER

VALIDATE (){
    if [ $1 -ne 0 ]; then
        echo -e "Error:: $R $2 $N Command Not Found." | tee -a $LOG_FILE
        exit 1
    else    
        echo -e "$2 $G Success $N" | tee -a $LOG_FILE
    fi
}

dnf module disable nodejs -y &>> $LOG_FILE
VALIDATE $? "Disable NodeJS"

dnf module enable nodejs:20 -y &>> $LOG_FILE
VALIDATE $? "Enable NodeJS"

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
VALIDATE $? "Create System User"

mkdir -p /app &>> $LOG_FILE
VALIDATE $? "Create app Directory"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip &>> $LOG_FILE
VALIDATE $? "Downloading Code"

cd /app &>> $LOG_FILE
VALIDATE $? "Goto App Directory"

rm -rf /app/*
VALIDATE $? "Remove existing Code"

unzip /tmp/catalogue.zip &>> $LOG_FILE
VALIDATE $? "Extract zip code"

npm install &>> $LOG_FILE
VALIDATE $? "Installing Dependencies"

cp $SCRIPT_DIR/catalogue.service /etc/systemd/system/catalogue.service &>> $LOG_FILE
VALIDATE $? "Copy Service"

systemctl daemon-reload &>> $LOG_FILE
VALIDATE $? "Daemon-Reload"

systemctl enable catalogue &>> $LOG_FILE
VALIDATE $? "Enable Service"

systemctl start catalogue &>> $LOG_FILE
VALIDATE $? "Starting Service"
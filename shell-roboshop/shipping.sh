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
MYSQL_HOST=mysql.techaws.shop
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

# installing maven
dnf install maven -y &>> $LOG_FILE
VALIDATE $? "Installing Maven"
# create user
id roboshop &>> $LOG_FILE
if [ $? -ne 0 ]; then
    useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>> $LOG_FILE
    VALIDATE $? "Create User"
else 
    echo -e "User already exists $Y Skipping $N"
fi
# download code and unzip code
mkdir -p /app
curl -L -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip &>> $LOG_FILE
cd /app 
rm -rf /app/*
unzip /tmp/shipping.zip &>> $LOG_FILE
VALIDATE $? "Download Code"
# install dependencies
mvn clean package &>> $LOG_FILE
mv target/shipping-1.0.jar shipping.jar &>> $LOG_FILE
VALIDATE $? "Install Dependencies"
# start service
cp $SCRIPT_DIR/shipping.service /etc/systemd/system/shipping.service
systemctl daemon-reload
systemctl enable shipping &>> $LOG_FILE
systemctl start shipping &>> $LOG_FILE
VALIDATE $? "Start Service"
# loading citis information
dnf install mysql -y &>> $LOG_FILE
mysql -h $MYSQL_HOST -uroot -pRoboShop@1 -e 'use cities' &>> $LOG_FILE
if [ $? -ne 0 ]; then
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/schema.sql  &>> $LOG_FILE
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/app-user.sql &>> $LOG_FILE
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/master-data.sql &>> $LOG_FILE
    VALIDATE $? "Load Cities Info"
else 
    echo -e "Cities info already exists $Y Skipping $N"
fi

systemctl daemon-reload
systemctl enable shipping &>> $LOG_FILE
systemctl restart shipping &>> $LOG_FILE
VALIDATE $? "Start Shipping Service"






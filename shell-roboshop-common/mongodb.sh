#!/bin/bash
source ./common.sh
check_root

cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOG_FILE
VALIDATE $? "Adding mongo repo"

dnf install mongodb-org -y  &>> $LOG_FILE
VALIDATE $? "Installing MongoDB"

systemctl enable mongod  &>> $LOG_FILE
VALIDATE $? "Enable MongoDB"

systemctl start mongod &>> $LOG_FILE
VALIDATE $? "Start MongoDB"

sed -i "s/127.0.0.1/0.0.0.0/g" /etc/mongod.conf
VALIDATE $? "Allowing Internet Connection"

systemctl restart mongod &>> $LOG_FILE
VALIDATE $? "Restart Service"
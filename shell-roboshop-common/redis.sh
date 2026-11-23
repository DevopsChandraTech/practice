#!/bin/bash

source ./common.sh
check_root

dnf module disable redis -y &>> $LOG_FILE
VALIDATE $? "Disable Redis" 
dnf module enable redis:7 -y &>> $LOG_FILE
VALIDATE $? "Enable Redis" 
dnf install redis -y &>> $LOG_FILE
VALIDATE $? "Install Redis"
sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>> $LOG_FILE
VALIDATE $? "Update Network"
systemctl daemon-reload
systemctl restart redis
VALIDATE $? "Restart Service"
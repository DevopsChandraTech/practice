#!/bin/bash

source ./common.sh
app_name=catalogue

check_root
app_setup
nodejs_setup
systemd_setup

cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOG_FILE
VALIDATE $? "Update MongoRepo"
dnf install mongodb-mongosh -y &>> $LOG_FILE
VALIDATE $? "Install MongDB Client"
mongosh --host $MONGODB_HOST </app/db/master-data.js &>> $LOG_FILE
VALIDATE $? "Load MasterData"




#!/bin/bash

source ./common.sh
app_name=catalogue

check_root
app_setup
nodejs_setup
systemd_setup

cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "Update MongoRepo"
dnf install mongodb-mongosh -y
VALIDATE $? "Install MongDB Client"
mongosh --host $MONGODB_HOST </app/db/master-data.js
VALIDATE $? "Load MasterData"




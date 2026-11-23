#!/bin/bash

source ./common.sh
app_name=catalogue

check_root
app_setup
nodejs_setup
systemd_setup

dnf install mongodb-mongosh -y
mongosh --host $MONGODB_HOST </app/db/master-data.js




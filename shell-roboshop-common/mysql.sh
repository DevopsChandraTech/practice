#!/bin/bash
source ./common.sh
check_root

dnf install mysql-server -y &>> $LOG_FILE
VALIDATE $? "Install MySql"
systemctl enable mysqld &>> $LOG_FILE
systemctl start mysqld  &>> $LOG_FILE
VALIDATE $? "Start MySql Service"
mysql_secure_installation --set-root-pass RoboShop@1 &>> $LOG_FILE
VALIDATE $? "Create System Password"

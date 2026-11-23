#!/bin/bash

dnf install mysql-server -y
VALIDATE $? "Install MySql"
systemctl enable mysqld
systemctl start mysqld  
VALIDATE $? "Start MySql Service"
mysql_secure_installation --set-root-pass RoboShop@1
VALIDATE $? "Create System Password"

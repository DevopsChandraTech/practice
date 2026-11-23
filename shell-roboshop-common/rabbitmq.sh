#!/bin/bash

source ./common.sh
check_root

cp $SCRIPT_DIR/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>> $FILE_NAME
VALIDATE $? "Update Repo"
dnf install rabbitmq-server -y &>> $FILE_NAME
VALIDATE $? "Install RabbitMQ"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
VALIDATE $? "Start RabbitMQ Service"
rabbitmqctl add_user roboshop roboshop123 &>> $FILE_NAME
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>> $FILE_NAME
VALIDATE $? "Adding User"
systemctl restart rabbitmq-server
VALIDATE $? "Restart Service"


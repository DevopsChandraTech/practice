#!/bin/bash

source ./common.sh
check_root

dnf install rabbitmq-server -y
VALIDATE $? "Install RabbitMQ"
systemctl enable rabbitmq-server
systemctl start rabbitmq-server
VALIDATE $? "Start RabbitMQ Service"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
VALIDATE $? "Adding User"
systemctl restart rabbitmq
VALIDATE $? "Restart Service"


#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

echo "the script started executed in $(date)"
START_TIME=$(date +%s)

LOG_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$(echo $0 | cut -d "." -f 1) #($(echo $0 | awk -F "-" '{print $1}'))
FILE_NAME=$LOG_FOLDER/$SCRIPT_NAME.log

mkdir -p /var/log/shell-script

VALIDATE(){
    if [ $? -ne 0 ]; then
        echo "Error::command not found" | tee -a $FILE_NAME
        exit 1
    else 
        echo -e "UnInstalling $2 $G Success..! $N" | tee -a $FILE_NAME
    fi
}

AMI_ID="ami-0055977a6e828a4f4"
SG_ID="sg-0f5bdd34affdd5ed7"

for instance in $@;

INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" --query 'Instances[0].InstanceId' --output text)
do 
    if [ $instance != 'frontend' ]; then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].NetworkInterfaces[0].Instances[0].PrivateIpAddress' --output text)
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].NetworkInterfaces[0].Instances[0].PublicIpAddress' --output text)
    fi
$instance=$IP

done
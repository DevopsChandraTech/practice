#!/bin/bash

AMI_ID="ami-0220d79f3f480ecf5"
SG_ID="sg-0f5bdd34affdd5ed7"

for instance in $@
do
    INSTANCE_ID=$(aws ec2 run-instances --image-id $AMI_ID --instance-type t3.micro --security-group-ids $SG_ID --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=test}]' --query 'Instances[0].InstanceId' --output text)
    if [ $instance == "frontend" ]; then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[0].Instances[0].PublicIpAddress' --output text --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=$instance}]')
    else
        IP=$(aws ec2 describe-instances --instance-ids i-0785dd541edf5f9a8 --query 'Reservations[*].Instances[*].PrivateIpAddress' --output text --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=$instance}]')
    fi
    
    echo $instance=$IP

done
#!/bin/bash

AMI_ID="ami-0055977a6e828a4f4"
SG_ID="sg-0f5bdd34affdd5ed7"

for instance in $@;

    INSTANCE_ID=$(aws ec2 run-instances \
        --image-id $AMI_ID \
        --instance-type t3.micro \
        --security-group-ids $SG_ID \
        --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value='$instance'}]" \
        --query 'Instances[0].InstanceId' --output text)
 
do 
    if [ $instance != 'frontend' ]; then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[*].NetworkInterfaces[*].Instances[*].PrivateIpAddress' --output text)
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query 'Reservations[*].NetworkInterfaces[*].Instances[*].PublicIpAddress' --output text)
    fi
$instance=$IP

done
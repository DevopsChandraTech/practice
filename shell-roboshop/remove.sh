#!/bin/bash

for instance in $@;
do
    INSTANCE_ID=$(aws ec2 describe-instances \
    --filters "Name=instance-state-name,Values=running" "Name=tag:Name,Values=$instance" \
    --query "Reservations[].Instances[].InstanceId" \
    --output text)
    if [ $instance == 0 ]; then
        aws ec2 terminate-instances --instance-ids $INSTANCE_ID
        echo "Instance $instance Terminated Successfully...!"
    else 
        echo "Error:: Check the Instance..!"
    fi
done

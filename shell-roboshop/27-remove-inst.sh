#!/bin/bash

for instance in "$@"; do
    INSTANCE_ID=$(aws ec2 describe-instances \
        --filters "Name=instance-state-name,Values=running" "Name=tag:Name,Values=$instance" \
        --query "Reservations[].Instances[].InstanceId" \
        --output text)

    if [ -z "$INSTANCE_ID" ]; then
        echo "Error:: Instance '$instance' not found or not running!"
    else
        aws ec2 terminate-instances --instance-ids "$INSTANCE_ID"
        echo "Instance $instance terminated successfully!"
    fi
done   

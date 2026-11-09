#!/bin/bash

for instance in "$@"; do
    INSTANCE_IDS=$(aws ec2 describe-instances \
        --filters "Name=instance-state-name,Values=running" \
        --query "Reservations[].Instances[].InstanceId" \
        --output text)

    if [ -z "$INSTANCE_IDS" ]; then
        echo "Error:: Instance '$instance' not found or not running!"
    else
        aws ec2 terminate-instances --instance-ids "$INSTANCE_IDS"
        echo "Instance $instance terminated successfully!"
    fi
done   


# remove all instances except a specific instance like runner

# INSTANCE_IDS=$(aws ec2 describe-instances \
#     --filters "Name=instance-state-name,Values=running" "Name=tag:Name,Values=*runner*" \
#     --query "Reservations[].Instances[].InstanceId" \
#     --output text)

# if [ -z "$INSTANCE_IDS" ]; then
#     echo "No running instances with 'runner' in name found."
# else
#     aws ec2 terminate-instances --instance-ids $INSTANCE_IDS
#     echo "All 'runner' instances terminated successfully!"
# fi   
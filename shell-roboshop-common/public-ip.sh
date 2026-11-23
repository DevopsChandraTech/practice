#!/bin/bash

for instance in $@;
do 
    PublicIP=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=$instance" \
    --query "Reservations[*].Instances[*].PublicIpAddress" \
    --output text)

    echo "$instance=$PublicIP"
done
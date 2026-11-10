#!/bin/bash

# to get the public ip with instance name off all instance with instance id (ex: i-058e3da1b2a69a2b0 |  mongodb |  54.152.10.103)   
# aws ec2 describe-instances \
#     --filters "Name=instance-state-name,Values=running" \
#     --query "Reservations[*].Instances[*].{InstanceId:InstanceId, Name:Tags[?Key=='Name']|[0].Value, PublicIP:PublicIpAddress}" \
#     --output table

# to get only public ip with name (mysql = 54.234.136.163)
aws ec2 describe-instances \
    --filters "Name=instance-state-name,Values=running" \
    --query "Reservations[*].Instances[*].[Tags[?Key=='Name']|[0].Value, PublicIpAddress]" \
    --output text

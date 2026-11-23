#!/bin/bash
# this is the first command of shell script interpreter to running the script

AMI_ID="ami-0055977a6e828a4f4"
INSTANCE_TYPE="t3.micro"
SECURITY_GROUP_ID="sg-0f5bdd34affdd5ed7"
HOSTED_ZONE_ID="Z08676551V7I14XTWRNXA"
DOMAIN_NAME="techaws.shop"

#if instance is frontend get publicip,else backend get privateip
#If multiple network interfaces exist, 
#use --query "Reservations[].Instances[].NetworkInterfaces[].PrivateIpAddress" to list all attached private IPs.
# give "" all tag-specifications and query otherwise not taken
for instance in $@;
do 
    INSTANCE_ID=$(aws ec2 run-instances \
    --image-id "$AMI_ID" \
    --instance-type "$INSTANCE_TYPE" \
    --security-group-ids "$SECURITY_GROUP_ID" \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
    --query 'Instances[0].InstanceId' \
    --output text )

    if [ $instance != "frontend" ]; then
        IP=$(aws ec2 describe-instances \
            --instance-ids $INSTANCE_ID \
            --query "Reservations[0].Instances[0].NetworkInterfaces[0].PrivateIpAddress" \
            --output text)
        RECORD_NAME="$instance.$DOMAIN_NAME"   
    else
        IP=$(aws ec2 describe-instances \
            --instance-ids $INSTANCE_ID \
            --query "Reservations[0].Instances[0].PublicIpAddress" \
            --output text)
        RECORD_NAME="$DOMAIN_NAME" 
    fi

    echo $instance=$IP

    aws route53 change-resource-record-sets \
    --hosted-zone-id $HOSTED_ZONE_ID \
    --change-batch '{
        "Changes": [
            {
                "Action": "UPSERT",
                "ResourceRecordSet": {
                    "Name": "'$RECORD_NAME'",
                    "Type": "A",
                    "TTL": 1,
                    "ResourceRecords": [
                        {
                            "Value": "'$IP'"
                        }
                    ]
                }
            }
        ]
    }'

done
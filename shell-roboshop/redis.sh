#!/bin/bash
#colours 
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USER_ID=$(id -u)
#checking root user privilizes
if [ $USER_ID -ne 0 ]; then
    echo "Error:: run command with root user privilizes"
fi

#print script execution time
START_TIME=$(date +%s)
echo "the script started executed by $(date)"

LOG_FOLDER="/var/log/shell-script"
FILE_NAME=$(echo "$0" | cut -d "." -f 1)
LOG_FILE=$LOG_FOLDER/$FILE_NAME.log

mkdir -p $LOG_FOLDER

VALIDATE (){
    if [ $1 -ne 0 ]; then
        echo -e "Error:: $R $2 $N Command Not Found." | tee -a $LOG_FILE
        exit 1
    else    
        echo -e $2 "$G Success $N" | tee -a $LOG_FILE
    fi
}

# Disable,Enable,Installing Redis Server
dnf module disable redis -y &>> $FILE_NAME
dnf module enable redis:7 -y &>> $FILE_NAME
dnf install redis -y  &>> $FILE_NAME
VALIDATE $? "Installing Redis Server"

# Update the Network port and Protected mode=no

sed -i -e 's/127.0.0.1/0.0.0.0/g' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>> $FILE_NAME
VALIDATE $? "Allowing Network Connections"

# Restarting Service
systemctl daemon-reload
systemctl enable redis &>> $FILE_NAME
systemctl start redis &>> $FILE_NAME
VALIDATE $? "Restarting Service"


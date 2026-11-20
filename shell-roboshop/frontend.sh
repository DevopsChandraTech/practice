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
echo "the script started executed by $date"

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

# install disable,enable,install nginx
dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y
VALIDATE $? "Installing Nginx"

# start nginx service
systemctl enable nginx 
systemctl start nginx 
VALIDATE $? "Start Nginx Service"

# download nginx config and html code, remove default code and add our html content and cofig file
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
rm -rf /usr/share/nginx/html/*
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
VALIDATE $? "Coping HTML Content"
# restart service
systemctl restart nginx 
VALIDATE $? "Restart Service"
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
SCRIPT_DIR=$PWD

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
dnf module disable nginx -y &>> $LOG_FILE
dnf module enable nginx:1.24 -y &>> $LOG_FILE
dnf install nginx -y &>> $LOG_FILE
VALIDATE $? "Installing Nginx"

# start nginx service
systemctl daemon-reload
systemctl enable nginx
systemctl start nginx
VALIDATE $? "Start Nginx Service"

# download nginx config and html code, remove default code and add our html content and cofig file
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>> $LOG_FILE
rm -rf /usr/share/nginx/html/* &>> $LOG_FILE
cd /usr/share/nginx/html &>> $LOG_FILE
unzip /tmp/frontend.zip &>> $LOG_FILE
VALIDATE $? "Coping HTML Content" &>> $LOG_FILE

# remove exisiting nginx config file and copy our nginx config file
rm -rf /etc/nginx/nginx.conf
cp $SCRIPT_DIR/nginx.conf /etc/nginx/nginx.conf
VALIDATE $? "Update Configfile"

# restart service
systemctl restart nginx  &>> $LOG_FILE
VALIDATE $? "Restart Service"
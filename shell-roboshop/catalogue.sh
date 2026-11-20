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

VALIDATE (){
    if [ $1 -ne 0 ]; then
        echo -e "Error:: $R $2 $N Command Not Found."
        exit 1
    else    
        echo -e "$G Success $N"
    fi
}

LOG_FOLDER="/var/log/shell-script"
FILE_NAME=$(echo "$0" | cut -d "." -f 1)
LOG_FILE=$LOG_FOLDER/$FILE_NAME.log

mkdir -p $LOG_FOLDER

dnf module disable nodejs -y
VALIDATE $? "Disable NodeJS"

dnf module enable nodejs:20 -y
VALIDATE $? "Enable NodeJS"

dnf install nodejs -y
VALIDATE $? "Installing NodeJS"

# the script runs many time but the comes with the same result is called idompotant
# here we run again the script "coming user already exist error" this is not idompotant
id roboshop # checks the roboshop pid exist or not
if [ $? -ne 0 ]; then

useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop
VALIDATE $? "Create System User"

mkdir -p /app
VALIDATE $? "Create app Directory"

curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
VALIDATE $? "Downloading Code"

cd /app
VALIDATE $? "Goto App Directory"

unzip /tmp/catalogue.zip
VALIDATE $? "Extract zip code"

npm install
VALIDATE $? "Installing Dependencies"

cp catalogue.service /etc/systemd/system/catalogue.service
VALIDATE $? "Copy Service"

systemctl daemon-reload
VALIDATE $? "Daemon-Reload"

systemctl enable catalogue
VALIDATE $? "Enable Service"

systemctl start catalogue
VALIDATE $? "Starting Service"
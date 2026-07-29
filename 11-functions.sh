#/bin/bash

echo "the script started executed in $(date)"

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "Error:: run script with root user privilizes"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ]; then
        echo -e "Command Not Found $R Failure..! $N"
        exit 1
    else
        echo -e "Installing $2 $G Success..! $N"
    fi
}

dnf list installed mysql 
if [ $? -ne 0 ]; then
    dnf install mysql -y
    VALIDATE $? MySql
else 
    echo -e "MySql already installed $Y Skipping..! $N"
fi


dnf list installed nginx 
if [ $? -ne 0 ]; then
    dnf install nginx -y
    VALIDATE $? Nginx
else 
    echo -e "Nginx already installed $Y Skipping..! $N"
fi

dnf list installed unzip
if [ $? -ne 0 ]; then
    dnf install unzip -y
    VALIDATE $? Unzip
else 
    echo -e "Unzip already installed $Y Skipping..! $N"
    exit 1
fi


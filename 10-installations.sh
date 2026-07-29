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

#mysql installation
dnf install mysql -y
if [ $? -ne 0 ]; then
    echo "Error:: MySql Command Not found"
    exit 1
else
    echo -e "Installing MySql $G Success..! $N"
fi

#nginx installation
dnf install nginx -y
if [ $? -ne 0 ]; then
    echo "Error:: Nginx Command Not found"
    exit 1
else
    echo -e "Installing Nginx $G Success..! $N"
fi

#unzip installation
dnf install unzip -y
if [ $? -ne 0 ]; then
    echo "Error:: Unzip Command Not found"
    exit 1
else
    echo -e "Installing Unzip $G Success..! $N"
fi


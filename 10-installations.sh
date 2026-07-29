#/bin/bash

echo "the script started executed in $(date)"

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
    echo "Installing MySql Success..!"
fi

#nginx installation
dnf install nginx -y
if [ $? -ne 0 ]; then
    echo "Error:: Nginx Command Not found"
    exit 1
else
    echo "Installing Nginx Success..!"
fi

#unzip installation
dnf install unzip -y
if [ $? -ne 0 ]; then
    echo "Error:: Unzip Command Not found"
    exit 1
else
    echo "Installing Unzip Success..!"
fi


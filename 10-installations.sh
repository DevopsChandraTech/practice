#/bin/bash

echo "the script started executed in $(date)"

USERID=$(id -u)

if [ $USERID -ne 0 ]; then
    echo "Error:: run script with root user privilizes"
fi

dnf install mysql -y
if [ $? -ne 0 ]; then
    echo "Error:: Command Not found"
else
    echo "Installing MySql Success..!"
fi

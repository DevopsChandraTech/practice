#!/bin/bash

source ./common.sh

check_root
app_name=shipping
app_setup
java_setup

dnf install mysql -y &>> $FILE_NAME
VALIDATE $? "Installing MySql"

mysql -h $MYSQL_HOST -uroot -pRoboShop@1 -e 'use cities' &>> $FILE_NAME
if [ $? -ne 0 ]; then
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/schema.sql &>> $FILE_NAME
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/app-user.sql &>> $FILE_NAME
    mysql -h $MYSQL_HOST -uroot -pRoboShop@1 < /app/db/master-data.sql &>> $FILE_NAME
    VALIDATE $? "Update Location Data"
else
    echo -e "Locations Data already Exists $Y Skipping...! $N"
fi

systemd_setup

# systemctl daemon-reload
# systemctl enable $app_name
# systemctl restart $app_name
# VALIDATE $? "Restart Shipping Service"





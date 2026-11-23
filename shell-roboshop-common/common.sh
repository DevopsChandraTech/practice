#colours 
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USER_ID=$(id -u)
#checking root user privilizes
check_root(){
    if [ $USER_ID -ne 0 ]; then
        echo "Error:: run command with root user privilizes"
    fi
}

#print script execution time
START_TIME=$(date +%s)
echo "the script started executed by $(date)"

LOG_FOLDER="/var/log/shell-script"
FILE_NAME=$(echo "$0" | cut -d "." -f 1)
LOG_FILE=$LOG_FOLDER/$FILE_NAME.log
SCRIPT_DIR=$PWD
MONGODB_HOST="mongodb.techaws.shop"
MYSQL_HOST="mysql.techaws.shop"

mkdir -p $LOG_FOLDER

VALIDATE (){
    if [ $1 -ne 0 ]; then
        echo -e "Error:: $R $2 $N Command Not Found." | tee -a $LOG_FILE
        exit 1
    else    
        echo -e $2 "$G Success $N" | tee -a $LOG_FILE
    fi
}

# nodejs setup
nodejs_setup(){
    dnf module disable nodejs -y &>> $LOG_FILE
    VALIDATE $? "Disable NodeJS"
    dnf module enable nodejs:20 -y &>> $LOG_FILE
    VALIDATE $? "Enable NodeJS"
    dnf install nodejs -y &>> $LOG_FILE
    VALIDATE $? "Installing NodeJS"
    cd /app
    VALIDATE $? "Change Directory"
    npm install &>> $LOG_FILE
    VALIDATE $? "Installing Dependencies"

    # the script runs many time but the comes with the same result is called idompotant
    # here we run again the script "coming user already exist error" this is not idompotant
}

app_setup(){
    mkdir -p /app &>> $LOG_FILE
    VALIDATE $? "Create Directory"
    id roboshop &>> $LOG_FILE # checks the roboshop pid exist or not
        if [ $? -ne 0 ]; then
            useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>> $LOG_FILE
            VALIDATE $? "Adding User"
        else
            echo -e "User already exists $Y Skipping..! $N" &>> $LOG_FILE
        fi
    curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip &>> $LOG_FILE
    VALIDATE $? "Download Code"
    cd /app &>> $LOG_FILE
    VALIDATE $? "Change Directory"
    rm -rf /app/*
    VALIDATE $? "Remove Content"
    unzip /tmp/$app_name.zip &>> $LOG_FILE
    VALIDATE $? "Unzip Code"
}
systemd_setup(){
    cp $SCRIPT_DIR/$app_name.service /etc/systemd/system/$app_name.service &>> $LOG_FILE
    systemctl daemon-reload &>> $LOG_FILE
    systemctl enable $app_name &>> $LOG_FILE
    systemctl start $app_name &>> $LOG_FILE
    VALIDATE $? "Start $app_name Service"
}

nginx_setup(){
    dnf module list nginx &>> $LOG_FILE
    VALIDATE $? "List Module"
    dnf module disable nginx -y &>> $LOG_FILE
    VALIDATE $? "Disable Nginx"
    dnf module enable nginx:1.24 -y &>> $LOG_FILE
    VALIDATE $? "Enable Nginx"
    dnf install nginx -y &>> $LOG_FILE
    VALIDATE $? "Install Nginx"
    systemctl daemon-reload
    systemctl enable nginx 
    systemctl start nginx &>> $LOG_FILE
    VALIDATE $? "Start Nginx Service"
    curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>> $LOG_FILE
    VALIDATE $? "Download HTML Code"
    rm -rf /usr/share/nginx/html/* &>> $LOG_FILE
    VALIDATE $? "Remove Default HTML Code" 
    cd /usr/share/nginx/html/ &>> $LOG_FILE
    VALIDATE $? "Change Directory"
    unzip /tmp/frontend.zip &>> $LOG_FILE
    VALIDATE $? "Unzip HTML Code"
    cp $SCRIPT_DIR/nginx.conf /etc/nginx/nginx.conf &>> $LOG_FILE
    VALIDATE $? "Config Directory"
    systemctl restart nginx &>> $LOG_FILE
    VALIDATE $? "Restart Nginx Service"
}

java_setup(){
    dnf install maven -y &>> $FILE_NAME
    VALIDATE $? "Installing Maven"
    mvn clean package  &>> $FILE_NAME
    mv target/shipping-1.0.jar shipping.jar  &>> $FILE_NAME
    VALIDATE $? "Installing Dependencies"
    cp $SCRIPT_DIR/shipping.service /etc/systemd/system/shipping.service &>> $FILE_NAME
    VALIDATE $? "Update Service"
    systemd_setup
}

python_setup(){
    dnf install python3 gcc python3-devel -y &>> $FILE_NAME
    VALIDATE $? "Install Python"
    pip3 install -r requirements.txt &>> $FILE_NAME
    VALIDATE $? "Install Dependencies"
    cp $SCRIPT_DIR/payment.service /etc/systemd/system/payment.service &>> $FILE_NAME
    VALIDATE $? "Create Service"
}



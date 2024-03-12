source common.sh

app_dir=/app
component=backend

mysql_root_password=$1
# If password is missing we have to exit

if [ -z "${mysql_root_password}" ]; then
  echo Input password is missing
  exit 1
fi

Print_Task_Heading "Disable defult Nodejs version module"
dnf module disable nodejs -y &>>$LOG
Check_status $?

Print_Task_Heading "Enable Nodejs module for v20"
dnf module enable nodejs:20 -y &>>$LOG
Check_status $?

Print_Task_Heading "Install Nodejs"
dnf install nodejs -y &>>$LOG
Check_status $?

Print_Task_Heading "Adding application user"
id expense &>>$LOG
if [ $? -ne 0 ]; then
  useradd expense
fi
Check_status $?

Print_Task_Heading "Copy backend service file"
cp backend.service /etc/systemd/system/backend.service &>>$LOG
Check_status $?


App-PreReq


Print_Task_Heading "Download Nodejs dependencies"
cd /app &>>$LOG
npm install &>>$LOG
Check_status $?

Print_Task_Heading "Start Backend service"
systemctl daemon-reload &>>$LOG
systemctl enable backend &>>$LOG
systemctl start backend &>>$LOG
Check_status $?

Print_Task_Heading "Install MySQL client"
dnf install mysql -y &>>$LOG
Check_status $?

Print_Task_Heading "Load schema"
mysql -h  mysql-dev.akhilsaidevops.online -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOG
Check_status $?
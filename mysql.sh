source common.sh

mysql_root_password=$1

if [ -z "${mysql_root_password}" ];  then
  echo "Input password is missing"
  exit 1
fi


Print_Task_Heading "Installing MYSQL server "
dnf install mysql-server -y &>>$LOG
Check_status $?

Print_Task_Heading "Start MYSQL service"
systemctl enable mysqld &>>$LOG
systemctl start mysqld &>>$LOG
Check_status $?

Print_Task_Heading "Setup MYSQL password"
echo 'show databases' |mysql -h 172.31.11.15 -uroot p${mysql_root_password} &>>$LOG
if [ $? -ne 0 ]; then
  mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOG
fi
Check_status $?
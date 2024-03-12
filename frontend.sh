source common.sh

app_dir=/usr/share/nginx/html
component=frontend


Print_Task_Heading "Installing nginx"
dnf install nginx -y &>>$LOG
Check_status $?

Print_Task_Heading "Copy expense nginx conf file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$LOG
Check_status $?


App-PreReq


Print_Task_Heading "Restart nginx"
systemctl enable nginx &>>$LOG
systemctl restart nginx &>>$LOG
Check_status $?

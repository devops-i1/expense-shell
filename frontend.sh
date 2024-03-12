source common.sh

Print_Task_Heading "Installing nginx"
dnf install nginx - &>>$LOG
Check_status $?

Print_Task_Heading "Enable & Start nginx"
systemctl enable nginx &>>$LOG
systemctl start nginx &>>$LOG

Print_Task_Heading "Copy expense nginx conf file"
cp expense.conf /etc/nginx/default.d/expense.conf &>>$LOG
Check_status $?

Print_Task_Heading "Clean old content"
rm -rf /usr/share/nginx/html/* &>>$LOG
Check_status $?

Print_Task_Heading "Downloading frontend app content"
curl -o /tmp/frontend.zip https://expense-artifacts.s3.amazonaws.com/expense-frontend-v2.zip &>>$LOG
Check_status $?

Print_Task_Heading "Extract frontend app content"
cd /usr/share/nginx/html &>>$LOG
unzip /tmp/frontend.zip &>>$LOG
Check_status $?

Print_Task_Heading "Restart nginx"
systemctl restart nginx &>>$LOG
Check_status $?

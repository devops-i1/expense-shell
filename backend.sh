mysql_root_password=$1

echo Disable defult Nodejs version module
dnf module disable nodejs -y &>>/tmp/expense.log
echo $?

echo Enable Nodejs module for v20
dnf module enable nodejs:20 -y &>>/tmp/expense.log
echo $?

echo Install Nodejs
dnf install nodejs -y &>>/tmp/expense.log
echo $?

echo Adding application user
useradd expense &>>/tmp/expense.log
echo $?

echo Copy backend service file
cp backend.service /etc/systemd/system/backend.service &>>/tmp/expense.log
echo $?

echo Clean the old content
rm -rf /app &>>/tmp/expense.log
echo $?

echo Craete app directory
mkdir /app &>>/tmp/expense.log
echo $?

echo Download app content
curl -o /tmp/backend.zip https://expense-artifacts.s3.amazonaws.com/expense-backend-v2.zip &>>/tmp/expense.log
echo $?

echo Extract app content
cd /app &>>/tmp/expense.log
unzip /tmp/backend.zip &>>/tmp/expense.log
echo $?

echo Download Nodejs dependencies
cd /app &>>/tmp/expense.log
npm install &>>/tmp/expense.log
echo $?

echo Start Backend service
systemctl daemon-reload &>>/tmp/expense.log
systemctl enable backend &>>/tmp/expense.log
systemctl start backend &>>/tmp/expense.log
echo $?

echo Install MySQL client
dnf install mysql -y &>>/tmp/expense.log
echo $?

echo Load schema
mysql -h 172.31.10.122 -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>/tmp/expense.log
echo $?
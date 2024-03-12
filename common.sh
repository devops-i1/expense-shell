LOG=/tmp/expense.log

Print_Task_Heading () {
  echo $1
  echo "############### $1 ###############" &>>$LOG
}


Check_status() {
  if [ $? -eq 0 ]; then
    echo -e "\e[32mSUCCESS\e[0m"
  else
    echo -e "\e[31mFAILURE\e[0m"
    exit 2
  fi
}


App-PreReq() {
  Print_Task_Heading "Clean the old content"
  rm -rf ${app_dir} &>>$LOG
  Check_status $?

  Print_Task_Heading "Craete app directory"
  mkdir ${app_dir} &>>$LOG
  Check_status $?

  Print_Task_Heading "Download app content"
  curl -o /tmp/${component}.zip https://expense-artifacts.s3.amazonaws.com/expense-${component}-v2.zip &>>$LOG
  Check_status $?

  Print_Task_Heading "Extract app content"
  cd ${app_dir} &>>$LOG
  unzip /tmp/${component}.zip &>>$LOG
  Check_status $?
}
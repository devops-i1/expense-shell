Print_Task_Heading () {
  echo $1
  echo "#############" $1 "############"  &>>/tmp/expense.log
}


Check_status() {
  if [ $? -eq 0 ]; then
    echo -e "\e[31mSUCCESS\e[0m"
  else
    echo -e "\e[32mFAILURE\e[0m"
  fi
}
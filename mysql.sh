source common.sh
echo -e "\e[35m<<<<<<<<<<  download mysql repos  >>>>>>>>>\e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo &>>${log}
func_exit_status

echo -e "\e[35m<<<<<<<<<<  disable mysql  >>>>>>>>>\e[0m"
yum module disable mysql -y &>>${log}
func_exit_status

echo -e "\e[35m<<<<<<<<<<  install mysql  >>>>>>>>>\e[0m"
yum install mysql-community-server -y &>>${log}
func_exit_status

echo -e "\e[35m<<<<<<<<<<  start mysql  >>>>>>>>>\e[0m"
systemctl enable mysqld &>>${log}
systemctl start mysqld &>>${log}
func_exit_status


echo -e "\e[35m<<<<<<<<<<  give password  >>>>>>>>>\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
mysql -uroot -pRoboShop@1 &>>${log}
func_exit_status

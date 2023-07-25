source common.sh
echo -e "\e[35m<<<<<<<<<<  download mysql repos  >>>>>>>>>\e[0m"
cp mysql.repo /etc/yum.repos.d/mysql.repo
func_exit_status

echo -e "\e[35m<<<<<<<<<<  disable mysql  >>>>>>>>>\e[0m"
yum module disable mysql -y
func_exit_status

echo -e "\e[35m<<<<<<<<<<  install mysql  >>>>>>>>>\e[0m"
yum install mysql-community-server -y
func_exit_status

echo -e "\e[35m<<<<<<<<<<  start mysql  >>>>>>>>>\e[0m"
systemctl enable mysqld
systemctl start mysqld
func_exit_status


echo -e "\e[35m<<<<<<<<<<  give password  >>>>>>>>>\e[0m"
mysql_secure_installation --set-root-pass RoboShop@1
mysql -uroot -pRoboShop@1
func_exit_status

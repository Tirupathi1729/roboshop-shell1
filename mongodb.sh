source common.sh
echo -e "\e[35m<<<<<<<<<<  copy mongodb repo  >>>>>>>>>\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo
func_exit_status

echo -e "\e[35m<<<<<<<<<<  install mongodb >>>>>>>>>\e[0m"
yum install mongodb-org -y
func_exit_status
#update listen address from 127.0.0.1 to 0.0.0.

echo -e "\e[35m<<<<<<<<<<  start mongodb service  >>>>>>>>>\e[0m"
systemctl enable mongod
systemctl restart mongod
func_exit_status
source common.sh
echo -e "\e[35m<<<<<<<<<<  install redis repo  >>>>>>>>>\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y &>>${log}
func_exit_status

echo -e "\e[35m<<<<<<<<<<  enable redis6.2  >>>>>>>>>\e[0m"
yum module enable redis:remi-6.2 -y &>>${log}
func_exit_status

echo -e "\e[35m<<<<<<<<<<  install redis  >>>>>>>>>\e[0m"
yum install redis -y &>>${log}
func_exit_status

echo -e "\e[35m<<<<<<<<<<  Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis.conf & /etc/redis/redis.conf
>>>>>>>>>\e[0m"


echo -e "\e[35m<<<<<<<<<<  start redis  >>>>>>>>>\e[0m"
systemctl enable redis &>>${log}
systemctl restart redis &>>${log}
func_exit_status

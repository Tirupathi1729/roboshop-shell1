source common.sh
echo -e "\e[35m<<<<<<<<<<  rabbitmq repos  >>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash &>>${log}
func_exit_status

echo -e "\e[35m<<<<<<<<<<  rabbitmq repos1  >>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash &>>${log}
func_exit_status

echo -e "\e[35m<<<<<<<<<<  install rabbitmq  >>>>>>>>>\e[0m"
yum install rabbitmq-server -y &>>${log}
yum install rabbitmq-server -y &>>${log}
func_exit_status

echo -e "\e[35m<<<<<<<<<<  add username and pwd >>>>>>>>>\e[0m"
rabbitmqctl add_user roboshop roboshop123 &>>${log}
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>${log}
func_exit_status


echo -e "\e[35m<<<<<<<<<<  start rabbitmq  >>>>>>>>>\e[0m"
systemctl enable rabbitmq-server &>>${log}
systemctl restart rabbitmq-server &>>${log}
func_exit_status


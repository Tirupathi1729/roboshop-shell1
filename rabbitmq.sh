source common.sh
echo -e "\e[35m<<<<<<<<<<  install nginx  >>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | bash
func_exit_status

source common.sh
echo -e "\e[35m<<<<<<<<<<  install nginx  >>>>>>>>>\e[0m"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | bash
func_exit_status

source common.sh
echo -e "\e[35m<<<<<<<<<<  install nginx  >>>>>>>>>\e[0m"
yum install rabbitmq-server -y
yum install rabbitmq-server -y
func_exit_status

source common.sh
echo -e "\e[35m<<<<<<<<<<  install nginx  >>>>>>>>>\e[0m"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
func_exit_status


source common.sh
echo -e "\e[35m<<<<<<<<<<  install nginx  >>>>>>>>>\e[0m"
systemctl enable rabbitmq-server
systemctl restart rabbitmq-server
func_exit_status


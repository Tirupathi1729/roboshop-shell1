echo -e "\e[35m<<<<<<<<<<redis fetching repo successfully>>>>>>>>>\e[0m"
yum install https://rpms.remirepo.net/enterprise/remi-release-8.rpm -y

echo -e "\e[35m<<<<<<<<<enabling redis 6.2 successfully>>>>>>>>>\e[0m"
yum module enable redis:remi-6.2 -y

echo -e "\e[35m<<<<<<<<<<redis installation successfully>>>>>>>>>\e[0m"
yum install redis -y

echo -e "\e[35m<<<<<<<<<<Update listen address from 127.0.0.1 to 0.0.0.0>>>>>>>>>\e[0m"
#Update listen address from 127.0.0.1 to 0.0.0.0 in /etc/redis.conf & /etc/redis/redis.conf

echo -e "\e[35m<<<<<<<<<<redis started successfully>>>>>>>>>\e[0m"
systemctl enable redis
systemctl restart redis
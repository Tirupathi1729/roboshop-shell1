echo -e "\e[35m<<<<<<<<<<copy files successfully>>>>>>>>>\e[0m"
cp payment.service /etc/systemd/system/payment.service

echo -e "\e[35m<<<<<<<<<<python installation successfully>>>>>>>>>\e[0m"
yum install python36 gcc python3-devel -y

echo -e "\e[35m<<<<<<<<<<useradd successfully>>>>>>>>>\e[0m"
useradd roboshop


echo -e "\e[35m<<<<<<<<<<making directiory successfully>>>>>>>>>\e[0m"
mkdir /app

echo -e "\e[35m<<<<<<<<<<downloading and zipping successfully>>>>>>>>>\e[0m"
curl -L -o /tmp/payment.zip https://roboshop-artifacts.s3.amazonaws.com/payment.zip
cd /app
unzip /tmp/payment.zip
cd /app

echo -e "\e[35m<<<<<<<<<<3.6 successfully>>>>>>>>>\e[0m"
pip3.6 install -r requirements.txt

echo -e "\e[35m<<<<<<<<<<payment started successfully>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable payment
systemctl restart payment
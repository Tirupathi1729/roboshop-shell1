echo -e "\e[35m<<<<<<<<<<copy successfully>>>>>>>>>\e[0m"
cp user.service /etc/systemd/system/user.service

echo -e "\e[35m<<<<<<<<<<mongodb copy successfully>>>>>>>>>\e[0m"
cp mongo.repo /etc/yum.repos.d/mongo.repo

echo -e "\e[35m<<<<<<<<<<Setup NodeJS repos successfully>>>>>>>>>\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[35m<<<<<<<<<<nodejs installation successfully>>>>>>>>>\e[0m"
yum install nodejs -y

echo -e "\e[35m<<<<<<<<<<useradd successfully>>>>>>>>>\e[0m"
useradd roboshop

echo -e "\e[35m<<<<<<<<<<app directiory successfully>>>>>>>>>\e[0m"
mkdir /app
echo -e "\e[35m<<<<<<<<<<downloading and unzipping successfully>>>>>>>>>\e[0m"
curl -o /tmp/user.zip https://roboshop-artifacts.s3.amazonaws.com/user.zip
cd /app
unzip /tmp/user.zip
cd /app

echo -e "\e[35m<<<<<<<<<<dependencies downloaded successfully>>>>>>>>>\e[0m"
npm install

echo -e "\e[35m<<<<<<<<<<mongodb installation successfully>>>>>>>>>\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[35m<<<<<<<<<<mongod server started successfully>>>>>>>>>\e[0m"
mongo --host mongodbtirupathib74.online </app/schema/catalogue.js

echo -e "\e[35m<<<<<<<<<<user started successfully>>>>>>>>>\e[0m"
systemctl daemon-reload
systemctl enable user
systemctl restart user

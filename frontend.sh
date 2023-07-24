#log=/tmp/roboshop.log
echo -e "\e[35m<<<<<<<<<<nginx installation successfully>>>>>>>>>\e[0m"
yum install nginx -y #&>>${log}
echo -e "\e[35m<<<<<<<<<<copy successfully>>>>>>>>>\e[0m"
cp nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf #&>>${log}



echo -e "\e[35m<<<<<<<<<<remove old files successfully>>>>>>>>>\e[0m"
rm -rf /usr/share/nginx/html/* #&>>${log}

echo -e "\e[35m<<<<<<<<<<downloading content successfully>>>>>>>>>\e[0m"
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip #&>>${log}

echo -e "\e[35m<<<<<<<<<<change directory successfully>>>>>>>>>\e[0m"
cd /usr/share/nginx/html #&>>${log}

echo -e "\e[35m<<<<<<<<<<unzip successfully>>>>>>>>>\e[0m"
unzip /tmp/frontend.zip #&>>${log}


echo -e "\e[35m<<<<<<<<<<nginx server started successfully>>>>>>>>>\e[0m"
systemctl enable nginx #&>>${log}
systemctl restart nginx #&>>${log}











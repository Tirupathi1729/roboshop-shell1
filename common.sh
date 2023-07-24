log=/tmp/roboshop.log
fun_apppreq() {
    echo -e "\e[35m<<<<<<<<<<  create Application User >>>>>>>>>\e[0m"
    useradd roboshop &>>${log}

    echo -e "\e[35m<<<<<<<<<<  cleanup existing application directory >>>>>>>>>\e[0m"
    rm -rf /app &>>${log}

    echo -e "\e[35m<<<<<<<<<<  create application directory >>>>>>>>>\e[0m"
    mkdir /app &>>${log}

    echo -e "\e[35m<<<<<<<<<<  download Application Content  >>>>>>>>>\e[0m"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}

    echo -e "\e[35m<<<<<<<<<<  extract application content  >>>>>>>>>\e[0m"
    cd /app &>>${log}
    unzip /tmp/${component}.zip &>>${log}

}
fun_systemd() {
    echo -e "\e[35m<<<<<<<<<<  start ${component} service  >>>>>>>>>\e[0m"
    systemctl daemon-reload &>>${log}
    systemctl enable ${component} &>>${log}
    systemctl restart ${component} &>>${log}
}
fun_nodejs() {


  echo -e "\e[35m<<<<<<<<<<  create ${component} service  >>>>>>>>>\e[0m"
  cp ${component}.service /etc/systemd/system/${component}.service &>>${log}

  echo -e "\e[35m<<<<<<<<<<  create mongodb repository  >>>>>>>>>\e[0m"
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}

  echo -e "\e[35m<<<<<<<<<<  install nodejs repos  >>>>>>>>>\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}

  echo -e "\e[35m<<<<<<<<<<  install nodejs  >>>>>>>>>\e[0m"
  yum install nodejs -y &>>${log}

  fun_apppreq

  echo -e "\e[35m<<<<<<<<<<  download nodejs dependencies  >>>>>>>>>\e[0m"
  npm install &>>${log}

  echo -e "\e[35m<<<<<<<<<<  install mongodb client  >>>>>>>>>\e[0m"
  yum install mongodb-org-shell -y &>>${log}

  echo -e "\e[35m<<<<<<<<<<  load ${component} schema  >>>>>>>>>\e[0m"
  mongo --host mongodbtirupathib74.online </app/schema/${component}.js &>>${log}

  fun_systemd

}

fun_java() {
  
  echo -e "\e[35m<<<<<<<<<<  create ${component} service  >>>>>>>>>\e[0m"
  cp ${component}.service /etc/systemd/system/${component}.service &>>${log}

  echo -e "\e[35m<<<<<<<<<<  install maven  >>>>>>>>>\e[0m"
  yum install maven -y &>>${log}

  fun_apppreq

  echo -e "\e[35m<<<<<<<<<<  Build ${component} service  >>>>>>>>>\e[0m"
  mvn clean package &>>${log}
  mv target/${component}-1.0.jar ${component}.jar &>>${log}
  
  echo -e "\e[35m<<<<<<<<<<  install Mysql client  >>>>>>>>>\e[0m"
  yum install mysql -y &>>${log}

  echo -e "\e[35m<<<<<<<<<<  load schema  >>>>>>>>>\e[0m"
  mysql -h mysql.tirupathib74.online -uroot -pRoboShop@1 < /app/schema/${component}.sql &>>${log}

  fun_systemd
  

}
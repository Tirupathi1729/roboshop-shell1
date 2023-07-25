log=/tmp/roboshop.log
func_exit_status() {
  if [ $? -eq 0 ];then
    echo -e"\e[32m success\e[0m"
  else
    echo -e"\e[32m failure\e[0m"
  fi
}
func_apppreq() {

    echo -e "\e[35m<<<<<<<<<<  create ${component} service  >>>>>>>>>\e[0m"
    cp ${component}.service /etc/systemd/system/${component}.service &>>${log}
    func_exit_status



    echo -e "\e[35m<<<<<<<<<<  create Application User >>>>>>>>>\e[0m"
    useradd roboshop &>>${log}
    func_exit_status


    echo -e "\e[35m<<<<<<<<<<  cleanup existing application directory >>>>>>>>>\e[0m"
    rm -rf /app &>>${log}
    func_exit_status


    echo -e "\e[35m<<<<<<<<<<  create application directory >>>>>>>>>\e[0m"
    mkdir /app &>>${log}
    func_exit_status


    echo -e "\e[35m<<<<<<<<<<  download Application Content  >>>>>>>>>\e[0m"
    curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}
    func_exit_status


    echo -e "\e[35m<<<<<<<<<<  extract application content  >>>>>>>>>\e[0m"
    cd /app &>>${log}
    unzip /tmp/${component}.zip &>>${log}
    func_exit_status


}
func_systemd() {
    echo -e "\e[35m<<<<<<<<<<  start ${component} service  >>>>>>>>>\e[0m"
    systemctl daemon-reload &>>${log}
    systemctl enable ${component} &>>${log}
    systemctl restart ${component} &>>${log}
    func_exit_status


}
func_schema_setup() {
  if [ "${schema_type}" == "mongodb" ]; then
    echo -e "\e[35m<<<<<<<<<<  install mongodb client  >>>>>>>>>\e[0m"
    yum install mongodb-org-shell -y &>>${log}
    func_exit_status


    echo -e "\e[35m<<<<<<<<<<  load ${component} schema  >>>>>>>>>\e[0m"
    mongo --host mongodbtirupathib74.online </app/schema/${component}.js &>>${log}
    func_exit_status

  fi

  if [ "${schema_type}" == "mysql" ]; then
    echo -e "\e[35m<<<<<<<<<<  install Mysql client  >>>>>>>>>\e[0m"
    yum install mysql -y &>>${log}
    func_exit_status


    echo -e "\e[35m<<<<<<<<<<  load schema  >>>>>>>>>\e[0m"
    mysql -h mysql.tirupathib74.online -uroot -pRoboShop@1 < /app/schema/${component}.sql &>>${log}
    func_exit_status

  fi
}


func_nodejs() {

  echo -e "\e[35m<<<<<<<<<<  create mongodb repository  >>>>>>>>>\e[0m"
  cp mongo.repo /etc/yum.repos.d/mongo.repo &>>${log}
  func_exit_status

  echo -e "\e[35m<<<<<<<<<<  install nodejs repos  >>>>>>>>>\e[0m"
  curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}
  func_exit_status


  echo -e "\e[35m<<<<<<<<<<  install nodejs  >>>>>>>>>\e[0m"
  yum install nodejs -y &>>${log}
  func_exit_status


  func_apppreq

  echo -e "\e[35m<<<<<<<<<<  download nodejs dependencies  >>>>>>>>>\e[0m"
  npm install &>>${log}
  func_exit_status


  func_schema_setup

  func_systemd

}

func_java() {
  

  echo -e "\e[35m<<<<<<<<<<  install maven  >>>>>>>>>\e[0m"
  yum install maven -y &>>${log}
  func_exit_status


  func_apppreq

  echo -e "\e[35m<<<<<<<<<<  Build ${component} service  >>>>>>>>>\e[0m"
  mvn clean package &>>${log}
  mv target/${component}-1.0.jar ${component}.jar &>>${log}
  func_exit_status

  
  func_schema_setup

  func_systemd
  

}

func_python() {


  echo -e "\e[35m<<<<<<<<<<  Build ${component} service>>>>>>>>>\e[0m"
  yum install python36 gcc python3-devel -y &>>${log}
  func_exit_status


  func_apppreq

  echo -e "\e[35m<<<<<<<<<<  Build ${component} service  >>>>>>>>>\e[0m"
  pip3.6 install -r requirements.txtn &>>${log}
  func_exit_status



  func_systemd

}
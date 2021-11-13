
#!/usr/bin/evn  bash

source /etc/profile

TOMCAT_HOME=/usr/local/tomcat

#ABSWAR=`cd ~; ls jeecg-boot-module-system/target/jeecg-boot-module-system-*.war`   ## 按实际调整

#PROJECT=$1                                                                         ## 可选，更新工程名, for example: ROOT

undeployTomcat() {
  PID=$(/usr/bin/ps -ef|grep -v grep |grep Bootstrap|awk '{print $2}')
  if [  ${PID} ]; then
  /usr/bin/kill -9 ${PID}
  fi
  /usr/bin/rm -rf  ${TOMCAT_HOME}/webapps/${PROJECT:-*}
  }


deployTomcat() {
  if [ -f ${ABSWAR} ];then
    WARFILE=${ABSWAR##*/}
    WAR=${WARFILE%.*}
    cp  ${ABSWAR}  ${TOMCAT_HOME}/webapps/${PROJECT:-${WAR}}.war
    ${TOMCAT_HOME}/bin/catalina.sh start
  fi
}

BanRquest() {
  local _BanPort=$1
  local _BanTime=$2
  /usr/sbin/iptables -I INPUT -p tcp --dport ${_BanPort} -j DROP
  sleep ${_BanTime:-60} 
  /usr/sbin/iptables  --flush
    }

main() {
  BanRquest 8080 60 &
  undeployTomcat
  deployTomcat
  }



ABSWAR=`cd ~; ls jeecg-boot-module-system/target/jeecg-boot-module-system-*.war`   ## 按实际调整
PROJECT=$1                                                                         ## 工程名， 按需调整 默认跟war文件名一致

main








#!/usr/bin/evn  bash


TOMCAT_HOME=/usr/local/tomcat

ABSWAR=`cd ~; ls jeecg-boot-module-system/target/jeecg-boot-module-system-*.war`   ## 按实际调整

PROJECT=$1                                                                         ## 可选，更新工程名, for example: ROOT

undeploy_tomcat() {
  PID=$(/usr/bin/ps -ef|grep -v grep |grep Bootstrap|awk '{print $2}')
  if [  ${PID} ]; then
  /usr/bin/kill -9 ${PID}
  fi
  /usr/bin/rm -rf  ${TOMCAT_HOME}/webapps/${PROJECT:-*}
  }


deploy_tomcat() {
  if [ -f ${ABSWAR} ];then
    WARFILE=${ABSWAR##*/}
    WAR=${WARFILE%.*}
    cp  ${ABSWAR}  ${TOMCAT_HOME}/webapps/${PROJECT:-${WAR}}.war
    ${TOMCAT_HOME}/bin/catalina.sh start
  fi
}


main() {
  undeploy_tomcat
  deploy_tomcat
  }


main





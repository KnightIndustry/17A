#!/bin/env  bash
# 0 2 * * * sh /home/sh/tomcatLogClean.sh 

for dir in "/home/wlw" "/opt/module/apache-tomcat-8.5.59/logs" "/usr/local/tomcat/logs" ; 
do
    if [ -d ${dir} ]; then
      find ${dir} \
        -type f -mtime +4 -name "*.log" -exec rm -f {} \; -or \
	-type f -mtime +4 -name "*.txt" -exec rm -f {} \; -or \
	-type f -mtime +4 -name "*.log.[0-9]*" -exec rm -f {} \;
    fi
	
done


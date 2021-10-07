
#!/usr/bin/env  bash

COMMAND=$1

loginpath=$2

logfilepath=/home/backup/logs

backuppath=/usr/local/backup

filepostfix=$(date +'%Y-%m-%d-%H-%M')

mysqlbackup() {
  
  echo "--------------------------------------------" >> ${logfilepath}/mysqlbackup.log
  echo "$(date +'%F %T') ${loginpath} 备份数据库开始" >> ${logfilepath}/mysqlbackup.log
  ${COMMAND}  --login-path=${loginpath}  \
             --compress=TRUE \
	     --single-transaction \
	     --master-data=2 --routines \
	     --set-gtid-purged=off --all-databases |/usr/bin/gzip  \
	     > ${backuppath}/${loginpath}/${loginpath}-${filepostfix}.sql.gz
  exitCode=$?
  if [ $exitCode == 0 ]; then
    echo "$(date +'%F %T') ${loginpath} 备份数据库成功" >> ${logfilepath}/mysqlbackup.log
    echo -e "--------------------------------------------\n\n" >> ${logfilepath}/mysqlbackup.log
  else
    echo "$(date +'%F %T') ${loginpath} 备份数据库失败" >> ${logfilepath}/mysqlbackup.log
    echo -e "--------------------------------------------\n\n" >> ${logfilepath}/mysqlbackup.log
  fi  
}

mysqlbackup 


#!/usr/bin/env  bash

COMMAND=$1

loginpath=$2

logfilepath=/home/backup/logs

backupdb="$3"
_dbargs=${backupdb:+--databases $backupdb}
_dumpdbargs="${_dbargs:---all-databases}"

backuppath=/usr/local/backup
_subpath=${backupdb:+single}
_pathargs=${backuppath}/${loginpath}/${_subpath:-full}


filepostfix=$(date +'%Y-%m-%d-%H-%M')

mysqlbackup() {
  
  echo "--------------------------------------------" >> ${logfilepath}/mysqlbackup.log
  echo "$(date +'%F %T') ${loginpath} ${_subpath}备份数据库开始" >> ${logfilepath}/mysqlbackup.log
  ${COMMAND}  --login-path=${loginpath}  \
             --compress=TRUE \
	     --single-transaction \
	     --master-data=2 --routines \
	     --set-gtid-purged=off  ${_dumpdbargs}  |/usr/bin/gzip  \
	     > ${_pathargs}/${loginpath}-${filepostfix}.sql.gz
  exitCode=$?
  if [ $exitCode == 0 ]; then
    echo "$(date +'%F %T') ${loginpath} ${_subpath}备份数据库成功" >> ${logfilepath}/mysqlbackup.log
    echo -e "--------------------------------------------\n\n" >> ${logfilepath}/mysqlbackup.log
  else
    echo "$(date +'%F %T') ${loginpath} ${_subpath}备份数据库失败" >> ${logfilepath}/mysqlbackup.log
    echo -e "--------------------------------------------\n\n" >> ${logfilepath}/mysqlbackup.log
  fi  
}

createbackupdir() {
  [ -d ${_pathargs} ] || /usr/bin/mkdir ${_pathargs}
}


createbackupdir
mysqlbackup 

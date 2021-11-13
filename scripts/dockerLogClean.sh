#!/usr/bin/env bash
#0 2 * * * sh /home/sh/tomcatLogClean.sh


echo "======== docker containers logs file size ========"
logs=$(find /var/lib/docker/containers/ -name *-json.log)
for log in $logs
do
ls -lh $log
done

#!/usr/bin/env bash
echo "======== start clean docker containers logs ========"
logs=$(find /var/lib/docker/containers/ -name *-json.log)
for log in $logs
do
echo "clean logs : $log"
cat /dev/null > $log
done
echo "======== end clean docker containers logs ========"


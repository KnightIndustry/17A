#!/usr/bin/env bash


deployNginx() {

cd /usr/local/nginx/html
[ -d ${DESTINATION} ] || mkdir -p ${DESTINATION}
/usr/bin/rm -rf ${DESTINATION}/*
/usr/bin/tar  --strip-components=1  --overwrite  -xf  dist.tar -C  ${DESTINATION}

/usr/bin/rm -f dist.tar

}


export DESTINATION="rzcf.com/bjwlw.rzcf.com"

deployNginx



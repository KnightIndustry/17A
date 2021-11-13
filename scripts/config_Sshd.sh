#!/usr/bin/env  bash

FILE=/etc/ssh/sshd_config

function config_sshd() {
_STATUS=$(grep -c '^[[:space:]]*UseDNS[[:space:]]'  ${FILE})

if [  ${_STATUS} == 0 ];then
  echo "UseDNS no" >> ${FILE}
else
  sed -i  's|^[[:space:]]*UseDNS.*|UseDNS no|' ${FILE}
fi

}

config_sshd
systemctl restart sshd


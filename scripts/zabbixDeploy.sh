#!/usr/bin/env bash


export PATH=/usr/sbin:$PATH

IPaddress=${/usr/sbin/ip -4 a|awk '$1~/inet/ && $2!~/127.0.0.1/{print $2}'|awk -F/ 'NR==1{print $1}'}

useradd -M -s /usr/sbin/nologin  zabbix
mkdir -p /usr/local/zabbix
curl -s http://172.168.188.160/sources/zabbix_agent-5.0.13-linux-3.0-amd64-static.tar.gz | tar -xzvf - -C /usr/local/zabbix/    --strip-components=1
chown -R zabbix:zabbix /usr/local/zabbix
sed -i 's/^Server=127.0.0.1/Server=192.168.67.8/;s/^ServerActive=127.0.0.1/ServerActive=192.168.67.8/' /usr/local/zabbix/conf/zabbix_agentd.conf


cat > /usr/lib/systemd/system/zabbix-agent.service  << EOF
[Unit]
Description=Zabbix Monitor Agent
After=syslog.target network.target

[Service]
Type=simple
ExecStart= /usr/local/zabbix/sbin/zabbix_agentd -f --config /usr/local/zabbix/conf/zabbix_agentd.conf
User=zabbix

[Install]
WantedBy=multi-user.target

EOF

systemctl enable --now  zabbix-agent

curl -s --connect-timeout 1 $IPaddress:10050 1>&2
Recv=$?
if [ $Recv = 52 ];then
  echo "port 10050 Detect Success "
else:
  echo "port 10050 Detect Faild "
fi



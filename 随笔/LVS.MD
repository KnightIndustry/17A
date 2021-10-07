内网IP：10.5.5.11       

外网IP：62.234.89.107



B机器：

内网IP：10.3.4.3

外网IP：212.129.135.110


#########################################################################
ip tunnel add tun1 mode gre remote 212.129.135.110 local 10.5.5.11 

ip link set tun1 up mtu 1400
ip addr add 192.168.1.1 peer 192.168.1.2 dev tun1
route add -net 10.3.0.0/16 dev tun1
echo 1 > /proc/sys/net/ipv4/ip_forward 
##################################################################
my config

ip tunnel add tun1 mode gre remote 212.129.135.110 local 43.228.125.189
ip link set tun1 up mtu 1400
ip  ad add 192.168.232.29 peer 192.168.232.30 dev tun1
route add -net 192.168.100.1/24 dev tun1



#################################################################
nmcli connection add type ip-tunnel ip-tunnel.mode gre con-name gre1 ifname gre1 remote 121.5.35.36 local 43.228.125.189 ipv4.method manual ipv4.address 192.168.232.29/30 +ipv4.routes "172.16.51.128/25 192.168.232.30"



grant all on *.* to root@'%' identified by 'mysqlpass' with grant option;
alter user root@'*' identified by 'mysqlpass';
update mysql.user set authentication_string=password('mysqlpass') where user='root' and Host='localhost';

flush privileges;

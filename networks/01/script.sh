#!/bin/bash
# Usage: ./script.sh <ip_addr>

apt-get -qq update
apt-get -q -y upgrade
apt-get install -y bind9 dnsutils
echo -e > /etc/bind/named.conf.local \ 'zone "lab.lokalne" {
\ttype master;
\tfile "/etc/bind/db.lab.lokalne";
};'

cp /etc/bind/db.local /etc/bind/db.lab.lokalne
sed -i -e 's/localhost/lab.lokalne/g' /etc/bind/db.lab.lokalne
echo -e >> /etc/bind/db.lab.lokalne \ "
www\tIN\tA\t$1
www1\tIN\tA\t$1"
/etc/init.d/bind9 restart
host www.lab.lokalne 127.0.0.1

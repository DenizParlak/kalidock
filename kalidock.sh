#!/bin/bash

#dp

if [[ $(id -u) -ne 0 ]]
then
echo "Root kullanıcısıyla giris yapın.!"
exit 1
fi

systemctl stop NetworkManager

systemctl start network
pkill dhclient

yum install docker docker-registry

systemctl start docker
systemctl enable docker

setenforce 0

docker pull jgamblin/kalibrowser

docker run -t -i -p 6680:6680 jgamblin/kalibrowser

x="$(hostname --all-ip-addresses)" | awk '{print $1}'

echo "Login $x:6680"

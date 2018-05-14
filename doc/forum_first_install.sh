#!/bin/sh

SHDIR=$(cd "`dirname $0`" && pwd)
echo $SHDIR

apt-get update
apt-get install software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
add-apt-repository 'deb [arch=amd64,i386] http://download.nus.edu.sg/mirror/mariadb/repo/10.0/ubuntu trusty main'
apt-get update

apt-get install subversion

install lib
apt-get install build-essential automake libtool libmariadbclient-dev libpcre3-dev
apt-get install ntp lrzsz
apt-get install curl libcurl3 libcurl3-dev 

#openresty
echo "start to install openresty....."
#ubuntu 系统多加这一步
apt-get install libssl-dev

cd /usr/local/src
wget "https://openresty.org/download/openresty-1.9.7.5.tar.gz"
tar -zxvf openresty-1.9.7.5.tar.gz
cd openresty-1.9.7.5/
 ./configure --prefix=/usr/local/openresty --with-pcre-jit --without-http_redis2_module --with-http_iconv_module -j2 --with-http_stub_status_module
 make -j2 && make install
echo "install openresty success....."

#mongodb
echo "start to install mongodb....."
mkdir -p /usr/local/mongodb
cd /usr/local/mongodb
wget "http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-ubuntu1404-3.4.2.tgz"
tar -zxvf mongodb-linux-x86_64-ubuntu1404-3.4.2.tgz
cd mongodb-linux-x86_64-ubuntu1404-3.4.2/bin
mkdir -p /data/db
ln -sf /usr/local/mongodb/mongodb-linux-x86_64-ubuntu1404-3.4.2/bin/mongod /usr/sbin
#./mongod --dbpath=/data/db &
echo "end install mongodb and start success..."

#node
echo "start to install nodejs......"
mkdir -p /usr/local/nodesrc
cd /usr/local/nodesrc
wget http://nodejs.org/dist/v5.2.0/node-v5.2.0.tar.gz
tar -zxvf node-v5.2.0.tar.gz
cd node-v5.2.0
./configure --prefix=/usr/local/node/5.2.0
make
make install
echo "end install node...."

#echo "start install npm..."
#apt-get install npm
#npm install -g cnpm --registry=https://registry.npm.taobao.org
#echo "end install nodejs..."

#php
#apt-get install php5-mysql php5-fpm php5-gd php5-mcrypt php5-curl php5-dev 

#php5enmod mcrypt
#chmod 777 /var/run/php5-fpm.sock

echo "install redies..."
mkdir -p /usr/local/
cd  /usr/local/
wget http://download.redis.io/redis-stable.tar.gz
tar -zxvf redis-stable.tar.gz
mkdir -p /usr/redis/
mv redis-stable /usr/redis
cd /usr/redis/redis-stable
cd src/
make install
redis-server &
echo "install redies end"

echo "000 finish install.."




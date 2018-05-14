#!/bin/sh

if [ "$LOGNAME" != "root" ]; then
	echo "please use root to upgrade system"
	exit 1
fi 

echo "check tmp install dir"
ls install.sh >/dev/null 2>&1 
if [ $? -ne 0 ]; then 
	echo "please run install.sh in package dir"
	exit 1 
fi

#echo "check version"
#version=`cat version`
#if [ $? -ne 0 ]; then 
#	echo "read version fail"
#	exit 1
#fi

#echo "stop process"
/ugw/script/stopall.sh >/dev/null 2>&1
#/etc/init.d/mysql stop
/ugw/script/stopall.sh >/dev/null 2>&1
#/etc/init.d/mysql stop

#openresty
mkdir -p /usr/local/openresty

#cp something
#cp -rp $current_dir/var/attachment/uploads/* /var/attachment/uploads
#cp -rp $current_dir/usr/local/openresty/* /usr/local/openresty

#a+x to folder
#chmod 777 -R /ugw/vanilla
#chmod 777 -R /var/www/html
#chmod 777 -R /var/attachment


#/etc/init.d/mysql start
#chmod a+x /ugw/script/dbinit.sh
#chmod a+x /ugw/script/cloud_db_update.sh
#chmod a+x /ugw/script/auth_cloud_db.sql
#/ugw/script/dbinit.sh
#/etc/init.d/mysql stop
ln -sf /usr/local/mongodb/mongodb-linux-x86_64-ubuntu1404-3.4.2/bin/mongod /usr/sbin/
ln -sf /usr/local/node/5.2.0/bin/node /usr/sbin/
ln -sf /usr/local/node/5.2.0/bin/npm /usr/sbin/
ln -sf /usr/bin/server-cli /usr/sbin/
ln -sf /usr/bin/server-server /usr/sbin/

mv /usr/local/openresty/nginx/conf/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf.bak
cp /ugw/etc/conf/openresty/nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
#ln -sf /usr/local/openresty/nginx/conf/nginx.conf /usr/sbin/
ln -sf /usr/local/openresty/nginx/sbin/nginx /usr/sbin/
mkdir -p /usr/local/openresty/nginx/lualib/forum
cp /ugw/etc/conf/openresty/forum /usr/local/openresty/nginx/lualib/ -r

echo '替换文件...'
rm /ugw/nodeclub-master/config.js
cp /ugw/etc/replace/config.js /ugw/nodeclub-master/config.js

rm /ugw/nodeclub-master/common/tools.js
cp /ugw/etc/replace/tools.js /ugw/nodeclub-master/common/tools.js

echo "添加图片路径..."
mkdir -p /usr/local/img/avatar/upload/
mkdir -p /usr/local/img/topicImg/topicImg/
mkdir -p /usr/local/img/topicImg/topicTmp/
mkdir -p /usr/local/img/KBSImg/KBSImg/
mkdir -p /usr/local/img/KBSImg/KBSTmp/
#增加公共头像图片
cp /ugw/etc/replace/commonpic.jpg /usr/local/img/avatar/upload/


#增加http头部
cp /ugw/etc/replace/*.lua /usr/local/openresty/lualib/resty/

#修改可执行权限：
echo "修改script  或/etc/init.d 执行权限..."
chmod  777  /ugw/etc/init.d/*
chmod 777 /ugw/script/*


#rm /ugw/nodeclub-master/ -r
#rm /ugw/webui/ -r

#cd /ugw/nodeclub-master
#解决bcrypt 模块错误
npm install bcrypt-nodejs
cd /ugw/nodeclub-master
npm install redis
npm install redis-connection-pool

#npm install nodemailer-smtp-transport@2.4.2
#npm install nodemailer@2.3.2

#echo "re-link apps"
#ln -sf /ugw/etc/init.d/ugwinit /etc/init.d/
#ln -sf /ugw/etc/init.d/sands /etc/init.d/
#ln -sf /ugw/etc/init.d/logserver /etc/init.d/
#ln -sf /ugw/etc/init.d/cfgmgr /etc/init.d/
#ln -sf /ugw/etc/init.d/rds /etc/init.d/
#ln -sf /ugw/etc/init.d/status /etc/init.d/
#ln -sf /ugw/etc/init.d/proxy-map /etc/init.d/
#ln -sf /ugw/etc/init.d/cfgpush /etc/init.d/
#ln -sf /ugw/etc/init.d/wxrds /etc/init.d/
cd /etc/init.d/
rm mongo
rm forum

ln -sf /ugw/etc/init.d/nginx /etc/init.d/
ln -sf /ugw/etc/init.d/mongo /etc/init.d/
ln -sf /ugw/etc/init.d/forum /etc/init.d/
chmod 777 /etc/init.d/mongo
chmod 777 /etc/init.d/forum
#重新加载配置

nginx
#nginx -s reload
nginx -c /usr/local/openresty/nginx/conf/nginx.conf

#restart 功能还没整好
/etc/init.d/mongo restart

/etc/init.d/forum restart

update-rc.d -f logserver remove >/dev/null 2>&1
update-rc.d logserver defaults 40 >/dev/null 2>&1

update-rc.d -f forum remove >/dev/null 2>&1
update-rc.d forum defaults 40 >/dev/null 2>&1

update-rc.d -f mongo remove >/dev/null 2>&1
update-rc.d mongo defaults 40 >/dev/null 2>&1

update-rc.d -f nginx remove >/dev/null 2>&1
update-rc.d nginx defaults 60 >/dev/null 2>&1

echo "install finish, reboot in 5s"
sleep 5
#reboot

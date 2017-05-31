#!/usr/bin/env bash

# clear
#rm nginx-1.10.2.tar.gz
rm -rf nginx-1.10.2
#rm nginx-http-concat-master.zip
rm -rf nginx-http-concat-master

export SCRIPT_PATH=$(cd `dirname $0`; pwd)
export NGINX_PATH=$SCRIPT_PATH/nginx-1.10.2

# download
if [ ! -f nginx-1.10.2.tar.gz ]; then
	wget http://nginx.org/download/nginx-1.10.2.tar.gz
fi
tar -zxvf nginx-1.10.2.tar.gz
mkdir $NGINX_PATH/logs

if [ ! -f nginx-http-concat-master.zip ]; then
	https://codeload.github.com/alibaba/nginx-http-concat/zip/master -O nginx-http-concat-master.zip 
fi
unzip nginx-http-concat-master.zip 

# configure && make && run
cd $NGINX_PATH
./configure --user=www --group=www --prefix=$NGINX_PATH/ --with-http_stub_status_module --with-http_gzip_static_module --with-ipv6 --with-http_sub_module --add-module=$SCRIPT_PATH/nginx-http-concat-master
make

cd ..
cp $SCRIPT_PATH/conf/nginx.conf $NGINX_PATH/conf/nginx.conf
$NGINX_PATH/objs/nginx -c $NGINX_PATH/conf/nginx.conf

open http://localhost:8989/css/??a.css,b.css

echo "============================="
echo "nginx-http-concat demo is ok~"
echo "============================="
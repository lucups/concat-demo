# 我的笔记

```
# 我当前的目录是 /Users/tony/tmp/

wget http://nginx.org/download/nginx-1.10.2.tar.gz
tar -zxvf nginx-1.10.2.tar.gz

wget https://codeload.github.com/alibaba/nginx-http-concat/zip/master
unzip nginx-http-concat-master.zip 

mv nginx-http-concat-master nginx-1.10.2

cd nginx-1.10.2

# 配置，修改 configure 文件(第67行)
NGX_PREFIX=${NGX_PREFIX:-/Users/tony/tmp/nginx-1.10.2}

# 执行配置
./configure --user=www --group=www --prefix=/Users/tony/tmp/nginx-1.10.2 --with-http_stub_status_module --with-http_gzip_static_module --with-ipv6 --with-http_sub_module --add-module=./nginx-http-concat-master

# 编译，注意编译后不要 install，编译完后，当前 nginx 源码目录下生成 objs 目录则说明编译成功
make 

# 修改 nginx 配置文件，将默认端口改为 8989，并增加 concat 相关的配置

location /static/css/ {
    concat on;
    concat_delimiter /* concat demo */; 
}

# concat，是否打开资源合并开关，选项：on | off，默认：off
# concat_types，模块处理的资源类型，默认：text/css application/x-javascript
# concat_unique，是否允许合并不同类型的资源，选项：on | off，默认：on
# concat_max_files，允许合并的最大资源数目，默认：10
# concat_delimiter，合并后的文件内容分隔符，用于区分不同文件的内容
# concat_ignore_file_error，是否忽略404或403错误，选项：on | off，默认：off

# 跑起来
/Users/tony/tmp/nginx-1.10.2/objs/nginx -c /Users/tony/tmp/nginx-1.10.2/conf/nginx.conf

# 重新加载配置文件
/Users/tony/tmp/nginx-1.10.2/objs/nginx -s reload

# 停止
/Users/tony/tmp/nginx-1.10.2/objs/nginx -s stop

```
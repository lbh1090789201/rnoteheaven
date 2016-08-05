# CentOS 6.5下安装mysql+nginx+ruby

```
版本号： V1.0
撰写人： 张文博
日期： 2016.08.05
```

## 系统信息
> 系统：CentOS 6.5 x64
> ruby 版本： 2.2.3
> rails 版本 ： 4.2

## 安装步骤
### 1. 安装 mysql (有 mysql 略过)
- 1.1 给CentOS添加rpm源，并且选择较新的源
```
# wget dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
# yum localinstall mysql-community-release-el6-5.noarch.rpm
# yum repolist all | grep mysql
# yum-config-manager --disable mysql55-community
# yum-config-manager --disable mysql56-community
# yum-config-manager --enable mysql57-community-dmr
# yum repolist enabled | grep mysql
```

- 1.2 安装 mysql 服务器
```
# yum install mysql-community-server
# 密码在mysql日志中，注意记录
```

- 1.3 启动 mysql
```
# service mysqld start
```

- 1.4 查看mysql是否自启动,并且设置开启自启动
```
# chkconfig --list | grep mysqld
# chkconfig mysqld on
```

- 1.5 配置密码文件
```
$ sudo mkdir –p /usr/local/.db/
$ sudo vi /usr/local/.db/mysql.pas
依次输入i命令，文件内容为mysql的密码，进入命令模式按Escape，输入:wq保存退出
$ sudo chown uprunning /usr/local/.db/mysql.pas
$ sudo chmod 400 /usr/local/.db/mysql.pas
```

### 2. 安装 Rvm (如不需多个Ruby版本共存略过)
- 2.1 安装公钥
```
curl -sSL https://rvm.io/mpapis.asc | gpg --import
gpg: 已创建目录‘/root/.gnupg’
gpg: 新的配置文件‘/root/.gnupg/gpg.conf’已建立
gpg: 警告：在‘/root/.gnupg/gpg.conf’里的选项于此次运行期间未被使用
gpg: 钥匙环‘/root/.gnupg/secring.gpg’已建立
gpg: 钥匙环‘/root/.gnupg/pubring.gpg’已建立
gpg: /root/.gnupg/trustdb.gpg：建立了信任度数据库
gpg: 密钥 D39DC0E3：公钥“Michal Papis (RVM signing) <mpapis@gmail.com>”已导入
gpg: 合计被处理的数量：1
gpg:           已导入：1  (RSA: 1)
```

- 2.2 安装rvm
```
# curl -L https://get.rvm.io | bash -s stable

  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 22721  100 22721    0     0   6915      0  0:00:03  0:00:03 --:--:--  113k
```

- 2.3 载入RVM环境并获取需要的支持安装包
```
# source /etc/profile.d/rvm.sh
# rvm requirements
```

- 2.4 配置命令行的环境

  - `vim .bash_profile`
  ```
  # 添加
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
  ```

  - `vim .bashrc`
  ```
    export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
  ```

### 3. 安装 Ruby 环境

- 如果安装了 RVM 执行
```
# rvm install 2.2.3
# rvm use 2.2.3 --default
```

- 如果没有RVM 执行
```
# sudo yum install ruby 2.2.3
```

### 4. 安装Passenger/nginx
- 4.1 安装 nginx
```
# gem install passenger
# passenger-install-nginx-module
安装过程中有以下交互
Which languages are you interested in?		回车
Automatically download and install Nginx?		1回车
Where do you want to install Nginx to?		回车
Press ENTER to continue.		回车
```

- 4.2 创建自签名证书
这一步是因为WebServer用到了https。
```
# openssl genrsa -out privkey.pem 2048
# openssl req -new -x509 -key privkey.pem -out cacert.pem -days 1095
过程中的交互输入如下。
Country Name (2 letter code) [AU]:CN
State or Province Name (full name) [Some-State]:Shanghai
Locality Name (eg, city) []:Shanghai
Organization Name (eg, company) [Internet Widgits Pty Ltd]:Huayi
Organizational Unit Name (eg, section) []:loan
Common Name (e.g. server FQDN or YOUR name) []:Huayi
Email Address []:webmaster@huayi.com
$ sudo cp cacert.pem /etc/ssl/private
$ sudo cp privkey.pem /etc/ssl/private
这一步所创建的证书存在一个问题，可能被提示存在安全问题，如果要想获得一个被主流浏览器所认可的证书，可向startssl申请一个公开的证书，或向其它渠道购买。
```

- 4.3 配置 nginx 路径
在/opt/nginx/conf/nginx.conf中加入以下代码，注意修改倒数第二行 root 路径
```
client_max_body_size 200M;
    server {
        listen       443 ssl;
        ssl                  on;
        ssl_certificate      /etc/ssl/private/cacert.pem;
        ssl_certificate_key  /etc/ssl/private/privkey.pem;

        ssl_session_timeout  5m;
        proxy_connect_timeout 300s;
        proxy_read_timeout 300s;
        proxy_send_timeout 300s;
        client_max_body_size 200M;

        ssl_protocols  SSLv2 SSLv3 TLSv1;
        ssl_ciphers  HIGH:!aNULL:!MD5;
        ssl_prefer_server_ciphers   on;

        root   /home/ryunkang/public;
        passenger_enabled on;
    }
```

- 4.4 设置 nginx 自启动
创建一个文件 `vim /etc/init.d/nginx` ,内容为：
```
#!/bin/sh
#
# nginx - this script starts and stops the nginx daemon
#
# chkconfig:   - 85 15
# description:  NGINX is an HTTP(S) server, HTTP(S) reverse \
#               proxy and IMAP/POP3 proxy server
# processname: nginx
# config:      /etc/nginx/nginx.conf
# config:      /etc/sysconfig/nginx
# pidfile:     /var/run/nginx.pid
# Source function library.
. /etc/rc.d/init.d/functions
# Source networking configuration.
. /etc/sysconfig/network
# Check that networking is up.
[ "$NETWORKING" = "no" ] && exit 0
nginx="/usr/sbin/nginx"
prog=$(basename $nginx)
NGINX_CONF_FILE="/etc/nginx/nginx.conf"
[ -f /etc/sysconfig/nginx ] && . /etc/sysconfig/nginx
lockfile=/var/lock/subsys/nginx
make_dirs() {
   # make required directories
   user=`$nginx -V 2>&1 | grep "configure arguments:" | sed 's/[^*]*--user=\([^ ]*\).*/\1/g' -`
   if [ -z "`grep $user /etc/passwd`" ]; then
       useradd -M -s /bin/nologin $user
   fi
   options=`$nginx -V 2>&1 | grep 'configure arguments:'`
   for opt in $options; do
       if [ `echo $opt | grep '.*-temp-path'` ]; then
           value=`echo $opt | cut -d "=" -f 2`
           if [ ! -d "$value" ]; then
               # echo "creating" $value
               mkdir -p $value && chown -R $user $value
           fi
       fi
   done
}
start() {
    [ -x $nginx ] || exit 5
    [ -f $NGINX_CONF_FILE ] || exit 6
    make_dirs
    echo -n $"Starting $prog: "
    daemon $nginx -c $NGINX_CONF_FILE
    retval=$?
    echo
    [ $retval -eq 0 ] && touch $lockfile
    return $retval
}
stop() {
    echo -n $"Stopping $prog: "
    killproc $prog -QUIT
    retval=$?
    echo
    [ $retval -eq 0 ] && rm -f $lockfile
    return $retval
}
restart() {
    configtest || return $?
    stop
    sleep 1
    start
}
reload() {
    configtest || return $?
    echo -n $"Reloading $prog: "
    killproc $nginx -HUP
    RETVAL=$?
    echo
}
force_reload() {
    restart
}
configtest() {
  $nginx -t -c $NGINX_CONF_FILE
}
rh_status() {
    status $prog
}
rh_status_q() {
    rh_status >/dev/null 2>&1
}
case "$1" in
    start)
        rh_status_q && exit 0
        $1
        ;;
    stop)
        rh_status_q || exit 0
        $1
        ;;
    restart|configtest)
        $1
        ;;
    reload)
        rh_status_q || exit 7
        $1
        ;;
    force-reload)
        force_reload
        ;;
    status)
        rh_status
        ;;
    condrestart|try-restart)
        rh_status_q || exit 0
            ;;
    *)
        echo $"Usage: $0 {start|stop|status|restart|condrestart|try-restart|reload|force-reload|configtest}"
        exit 2
esac
```

```
如果你是自定义编译安装的nginx，需要根据您的安装路径修改下面这两项配置：

nginx=”/usr/sbin/nginx” 修改成nginx执行程序的路径。

NGINX_CONF_FILE=”/etc/nginx/nginx.conf” 修改成配置文件的路径。
```

- 4.5 保存脚本文件后设置文件的执行权限：
```
chmod a+x /etc/init.d/nginx
```

- 4.6 启动 nginx
```
# /etc/init.d/nginx start
# /etc/init.d/nginx stop
```

- 4.7 使用chkconfig进行管理
  - 先将nginx服务加入chkconfig管理列表：
  ```
  chkconfig --add /etc/init.d/nginx
  ```

  - 加完这个之后，就可以使用service对nginx进行启动，重启等操作了。
  ```
  service nginx start
  service nginx stop
  ```

  - 设置终端模式开机启动：
  ```
  chkconfig nginx on
  ```

### 5. 启动项目
将项目压缩包，解压到 nginx root `/home/ryunkang` 目录下
```
$ cd ryunkang
$ bundle install
//注意：下边这条数据库初始化命令，只在初次部署时执行
$ RAILS_ENV=production bundle exec rake db:create db:migrate
```



## 参考资料
- [CentOS 6.5/6.6 安装mysql 5.7 最完整版教程](https://segmentfault.com/a/1190000003049498)
- [centos 6.5下安装mysql+nginx+redmine 3.1.0 笔记](http://my.oschina.net/soarwilldo/blog/508517)
- [安裝 Ruby](https://www.ruby-lang.org/zh_tw/documentation/installation/#yum)
- [Linux(CentOS)下设置nginx开机自动启动和chkconfig管理](http://unun.in/linux/225.html)

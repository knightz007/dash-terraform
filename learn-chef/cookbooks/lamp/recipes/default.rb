#
# Cookbook Name:: lamp
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
#!/bin/bash

#Update Centos with any patches
#yum update -y --exclude=kernel
execute 'yum update -y --exclude=kernel'


# Install Tools
#yum install -y nano git unzip screen
package ['nano','git','unzip','screen']



#Install Apache
yum install -y httpd httpd-devel httpd-tools
chkconfig --add httpd
chkconfig httpd on
service httpd stop

rm -rf /var/www/html
ln -s /vagrant /var/www/html

service httpd start

# PHP
yum install -y php php-cli php-common php-devel php-mysql


# MySQL
yum install -y mysql mysql-server mysql-devel
chkconfig --add mysqld
chkconfig mysqld on

service sqld start

mysql -u root -e "SHOW DATABASES";

# Download starter content
cd /vagrant
sudo -u vagrant wget -q https://raw.githubusercontent.com/knightz007/vagrant/master/files/index.html

sudo -u vagrant wget -q https://raw.githubusercontent.com/knightz007/vagrant/master/files/info.php


service httpd restart

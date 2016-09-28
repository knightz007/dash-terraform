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
#yum install -y httpd httpd-devel httpd-tools
package ['httpd','httpd-devel', 'httpd-devel', 'httpd-tools']

#chkconfig --add httpd
execute 'chkconfig --add httpd'
#chkconfig httpd on
execute 'chkconfig httpd on'

#service httpd stop
service "httpd" do
  action :stop
end

#rm -rf /var/www/html

execute "rm -rf /var/www/html" do
  only_if { File.exist?("/var/www/html") }
end

#ln -s /vagrant /var/www/html
execute 'ln -s /vagrant /var/www/html'

#service httpd start
service "httpd" do
  action :start
end

# PHP
#yum install -y php php-cli php-common php-devel php-mysql
package['php','php-cli','php-common','php-devel','php-mysql']

# MySQL
#yum install -y mysql mysql-server mysql-devel
package['mysql','mysql-server','mysql-devel']


#chkconfig --add mysqld
execute 'chkconfig --add mysqld'

#chkconfig mysqld on
execute 'chkconfig mysqld on'

#service sqld start
service "sqld" do
  action :start
end

#mysql -u root -e "SHOW DATABASES";
execute 'mysql -u root -e "SHOW DATABASES";'

# Download starter content
#cd /vagrant; sudo -u vagrant wget -q https://raw.githubusercontent.com/knightz007/vagrant/master/files/index.html
execute 'cd /vagrant; sudo -u vagrant wget -q https://raw.githubusercontent.com/knightz007/vagrant/master/files/index.html'

#cd /vagrant;sudo -u vagrant wget -q https://raw.githubusercontent.com/knightz007/vagrant/master/files/info.php
execute 'cd /vagrant;sudo -u vagrant wget -q https://raw.githubusercontent.com/knightz007/vagrant/master/files/info.php'

#service httpd restart
ervice "httpd" do
  action :restart
end
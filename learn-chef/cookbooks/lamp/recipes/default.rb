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
#execute 'chkconfig --add httpd'
#chkconfig httpd on
#execute 'chkconfig httpd on'

#service httpd stop
service "httpd" do
	supports :status => true, :restart => true, :reload => true
  	action [ :enable, :stop ]
 end

#rm -rf /var/www/html

# execute "rm -rf /var/www/html" do
#   only_if { File.exist?("/var/www/html") }
# end

#ln -s /vagrant /var/www/html
#execute 'ln -s /vagrant /var/www/html'

#service httpd start
service "httpd" do
  action :start
end

# PHP
#yum install -y php php-cli php-common php-devel php-mysql
package ['php','php-cli','php-common','php-devel','php-mysql']

# MySQL
#yum install -y mysql mysql-server mysql-devel
#package ['mysql-server']
package ['mariadb-server','mariadb']


#chkconfig --add mysqld
#execute 'chkconfig --add mysqld'

#chkconfig mysqld on
#execute 'chkconfig mysqld on'

#service sqld start
service "mariadb" do
	supports :status => true, :restart => true, :reload => true
 	action [ :enable, :start ]
 end

#mysql -u root -e "SHOW DATABASES";
execute 'mysql -u root -e "SHOW DATABASES";'

# Download starter content
#cd /vagrant; sudo -u vagrant wget -q https://raw.githubusercontent.com/knightz007/vagrant/master/files/index.html
#execute 'cd /var/www/html; sudo wget -q https://raw.githubusercontent.com/knightz007/vagrant/master/files/index.html'

template '/var/www/html/index.html' do
	source 'index.html.erb'
end

#cd /vagrant;sudo -u vagrant wget -q https://raw.githubusercontent.com/knightz007/vagrant/master/files/info.php
#execute 'cd /var/www/html; sudo wget -q https://raw.githubusercontent.com/knightz007/vagrant/master/files/info.php'

template '/var/www/html/info.php' do
	source 'info.php.erb'
end

#service httpd restart
service "httpd" do
  action :restart
end
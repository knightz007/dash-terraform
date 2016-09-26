#
# Cookbook Name:: tomcat
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
package 'java-1.7.0-openjdk-devel'

#sudo groupadd tomcat
group 'tomcat'

#sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat
user 'tomcat' do
	manage_home false
	home '/opt/tomcat'
	shell '/bin/nologin'
	group 'tomcat'

end

#wget http://mirrors.sonic.net/apache/tomcat/tomcat-8/v8.5.4/bin/apache-tomcat-8.5.4.tar.gz

remote_file 'apache-tomcat-8.0.32.tar.gz' do
	source 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.32/bin/apache-tomcat-8.0.32.tar.gz'
end

#sudo mkdir /opt/tomcat
directory '/opt/tomcat' do
	action :create
end

#sudo tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1
execute 'sudo tar xvf apache-tomcat-8*tar.gz -C /opt/tomcat --strip-components=1'


directory '/opt/tomcat/conf' do
	mode '0070'
end

#TODO: Not desired state
execute  "Set /opt/tomcat group recursively to tomcat" do
	command "sudo chgrp -R tomcat /opt/tomcat"
	#not_if { Etc.getpwuid(File.stat('/opt/tomcat').uid).name == "tomcat" }
end



#TODO: Not desired state
execute 'sudo chmod g+rwx /opt/tomcat/conf'


#TODO: Not desired state
execute 'sudo chmod g+r /opt/tomcat/conf/*'

#sudo chown -R tomcat webapps/ work/ temp/ logs/
execute 'sudo chown -R tomcat /opt/tomcat/webapps/ /opt/tomcat/work/ /opt/tomcat/temp/ /opt/tomcat/logs/'

#cd /opt && sudo chown -R tomcat tomcat/
execute 'sudo chown -R tomcat /opt/tomcat'
#execute 'sudo chmod g+rwx /opt/tomcat'

#sudo vi /etc/systemd/system/tomcat.service
template '/etc/systemd/system/tomcat.service' do
	source 'tomcat.service.erb'
end

execute 'sudo rm -f /opt/tomcat/conf/tomcat-users.xml'

template '/opt/tomcat/conf/tomcat-users.xml' do
	source 'tomcat-users.xml.erb'
end

execute 'sudo /opt/tomcat/bin/shutdown.sh'

execute 'sudo /opt/tomcat/bin/startup.sh'

#sudo systemctl daemon-reload
#execute 'sudo systemctl daemon-reload'
#execute 'sudo systemctl start tomcat'
#execute 'sudo systemctl enable tomcat'



#service 'tomcat' do
#     action [:start, :enable]
#end
#
# Cookbook Name:: learn_chef_httpd
# Recipe:: default
#
# Copyright (C) 2014
#
#
#
package 'httpd'

service 'httpd' do
  action [:enable, :start]
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
end

directory '/var/www/html/chef' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

#template '/var/www/html/chef/cheftest.html' do 
 # source 'cheftest.html.erb'
#end

service 'iptables' do
  action :stop
end


data_bag("webserver").each do |websvr|

env_bag_item = data_bag_item("webserver",websvr)
user=env_bag_item["user"]    	 

	 directory "/opt/#{user}" do
	  owner 'root'
	  group 'root'
	  mode '0755'
	  action :create
	end
end
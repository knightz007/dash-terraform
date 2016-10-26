#
# Cookbook Name:: webserver_test
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

# Install the Apache package.
package 'httpd'

service 'httpd'  do
	action [:enable, :start]
end

file '/var/www/html/index.html' do
  content '<html>
  <body>
    <h1>hello world</h1>
  </body>
</html>'
end
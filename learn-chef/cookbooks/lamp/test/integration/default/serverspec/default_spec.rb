require 'spec_helper'

describe package('nano','git','unzip','screen') do
  it { should be_installed }
end

describe package('httpd','httpd-devel', 'httpd-devel', 'httpd-tools') do
  it { should be_installed }
end


describe file('/var/www/html') do
  it { should be_symlink }
end


describe file('/var/www/html/info.php') do
	it { should exist }
	it { should be_directory }
end

describe 'lamp::default' do
   describe command("curl http://localhost/info.php") do
   	its(:stdout) { should match /PHP/ }
  end
end
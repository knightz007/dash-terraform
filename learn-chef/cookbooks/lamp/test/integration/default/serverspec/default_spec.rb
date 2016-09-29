require 'spec_helper'

describe package('nano','git','unzip','screen') do
  it { should be_installed }
end

describe package('httpd','httpd-devel', 'httpd-devel', 'httpd-tools') do
  it { should be_installed }
end

describe package('mariadb-server','mariadb') do
  it { should be_installed }
end



packages = [ 'nano', 'git', 'unzip', 'screen', 'httpd', 'httpd-devel', 'httpd-tools', 'mariadb-server','mariadb' ]

   packages.each do|p|
      describe package(p) do
        it { should be_installed }
      end
    end


describe file('/var/www/html/info.php') do
	it { should exist }	
end

describe file('/var/www/html/index.html') do
	it { should exist }	
end

describe 'lamp::default' do
   describe command("curl http://localhost/info.php") do
   	its(:stdout) { should match /PHP/ }
  end
  describe command("curl http://localhost/index.html") do
   	its(:stdout) { should match /lamp/ }
  end
end
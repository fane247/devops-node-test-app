#
# Cookbook:: node-server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'nginx'
include_recipe 'nodejs'
service 'nginx' do
	supports :restart => true, :reload => true, :start => true
	action [:enable, :start]
end


template '/etc/nginx/sites-available/default' do 

	source 'default.erb'
	mode '0755'
	owner 'root'
	group 'root'
	notifies :restart, "service[nginx]"

end

include_recipe 'pm2'


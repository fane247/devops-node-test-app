#
# Cookbook Name:: mongo_db
# Recipe:: default
#
# Copyright (c) 2017 The Authors, All Rights Reserved.



include_recipe 'sc-mongodb'

template '/lib/systemd/system/mongod.service' do 

	source 'mongod.service.erb'

end

template '/lib/systemd/system/mongod.service' do 

	source 'mongod.service.erb'

end
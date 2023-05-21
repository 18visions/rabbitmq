#
# Cookbook:: rabbitmq
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved. 
cookbook_file '/etc/yum.repos.d/rabbitmq.repo' do
  source 'rabbitmq.repo'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute 'yum update' do
  command 'sudo yum update -y'
end

['htop','nano','python3','logrotate','socat','rabbitmq-server'].each do |p|
  package p do
    action :install
  end
end

service 'rabbitmq-server' do
  action [:enable, :start]
end

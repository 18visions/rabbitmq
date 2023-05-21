#
# Cookbook:: rabbitmq
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved. 
execute 'rabbitmq signing key' do
  command 'rpm --import https://github.com/rabbitmq/signing-keys/releases/download/2.0/rabbitmq-release-signing-key.asc'
  action :run
end

execute 'erlang repository gpg key' do
  command 'rpm --import https://packagecloud.io/rabbitmq/erlang/gpgkey'
  action :run
end

execute 'rmq repository gpg key' do
  command 'rpm --import https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey'
  action :run
end

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

#yum_package 'rabbitmq-server' do
#  action :install
#end

['htop','nano','python3','logrotate','socat','rabbitmq-server'].each do |p|
  package p do
    action :install
  end
end

service 'rabbitmq-server' do
  action [:enable, :start]
end


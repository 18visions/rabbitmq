#
# Cookbook:: rabbitmq
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved. 
['htop','nano','python3'].each do |p|
  package p do
    action :install
  end
end

yum_package 'logrotate' do
  action :install
end

yum_package 'socat' do
  action :install
end

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

yum_package 'rabbitmq-server' do
  action :install
end

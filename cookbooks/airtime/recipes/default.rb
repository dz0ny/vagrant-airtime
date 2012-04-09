#
# Cookbook Name:: xml
# Recipe:: default
#
# Copyright 2010, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

if node.has_key?("ec2")
  server_fqdn = node['ec2']['public_hostname']
else
  server_fqdn = node['fqdn']
end

log "Cache path: #{Chef::Config[:file_cache_path]}" do
  action :nothing
end

remote_file "#{Chef::Config[:file_cache_path]}/airtime-2.1.0-beta3.tar.gz" do
  source "http://downloads.sourceforge.net/project/airtime/2.1.0-beta3/airtime-2.1.0-beta3.tar.gz"
  mode "0644"
end
execute "untar-airtime" do
  cwd Chef::Config[:file_cache_path]
  command "tar -xzf #{Chef::Config[:file_cache_path]}/airtime-2.1.0-beta3.tar.gz"
end
execute "install-airtime" do
  command "sudo #{Chef::Config[:file_cache_path]}/airtime-*/install_full/ubuntu/airtime-full-install"
end

log "Navigate to 'http://admin:admin@#{server_fqdn} to begin using Airtime. Login using User: admin Password: admin" do
  action :nothing
end

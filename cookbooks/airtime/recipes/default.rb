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
include_recipe "apache2"
include_recipe "apt"

if node.has_key?("ec2")
  server_fqdn = node['ec2']['public_hostname']
else
  server_fqdn = node['fqdn']
end

apt_repository "sourcefabric" do
  uri "http://apt.sourcefabric.org/"
  distribution node['lsb']['codename']
  components ["main"]
end

package "sourcefabric-keyring" do
  action :install
  options "-f --force-yes"
end

package "airtime" do
  action :install
  options "-f --force-yes"
end

apache_site "000-default" do
  enable false
end
execute "watch-music-folder" do
  command "sudo airtime-import watch add /vagrant/music"
end

log "Navigate to 'http://admin:admin@#{server_fqdn} to begin using Airtime User: admin Password: admin" do
  action :nothing
end

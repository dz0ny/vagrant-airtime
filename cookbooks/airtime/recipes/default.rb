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

#Only install under debian, ubuntu

package "git-core"

#nginx service
service "nginx" do
  supports :restart => true
  action [ :enable, :start ]
  ignore_failure true
end

#php5-fpm
service "php5-fpm" do
  supports :restart => true
  action [ :enable, :start ]
  ignore_failure true
end

if node.has_key?("ec2")
  server_fqdn = node['ec2']['public_hostname']
else
  server_fqdn = node['fqdn']
end

remote_file "#{Chef::Config[:file_cache_path]}/airtime-2.1-oneiric-fix.sh" do
  source "https://raw.github.com/gist/2343716/dd13f1490112a51147957e3ebc4d49179f6f185e/airtime-2.1-oneiric-fix.sh"
  mode "0644"
  not_if {File.exists?("/etc/airtime/airtime.conf")}
end

execute "prepare-airtime" do
  command "bash #{Chef::Config[:file_cache_path]}/airtime-2.1-oneiric-fix.sh"
  not_if "test -f /etc/airtime/airtime.conf"
end

execute "clone-airtime-dev" do
  cwd "/opt"
  command "sudo git clone -b devel git://github.com/sourcefabric/Airtime.git airtime/devel"
  not_if {File.exists?("/opt/airtime/devel/README")}
end

remote_file "/opt/airtime/devel/python_apps/pypo/liquidsoap_bin/liquidsoap_oneiric_amd64" do
  source "http://github.com/downloads/dz0ny/vagrant-airtime/liquidsoap_oneiric_amd64"
  mode "755"
  not_if {File.exists?("/opt/devel/python_apps/pypo/liquidsoap_bin/liquidsoap_oneiric_amd64")}
end

execute "install-airtime" do
  command "sudo /opt/airtime/devel/install_full/ubuntu/airtime-full-install-nginx"
  not_if {File.exists?("/etc/airtime/airtime.conf")}
  ignore_failure true
end

#remove isntalled directory and link git directory to server directory
directory "/usr/share/airtime" do
  recursive true
  action :delete
  not_if "test -L /usr/share/airtime"
end

link "/usr/share/airtime" do
  to "/opt/airtime/devel/airtime_mvc"
  not_if "test -L /usr/share/airtime"
end

##disable defaults
file "/etc/nginx/sites-enabled/default" do
  action :delete
  only_if {File.exists?("/etc/nginx/sites-enabled/default")}
  notifies :restart, "service[nginx]"
end
file "/etc/php5/fpm/pool.d/www.conf" do
  action :delete
  only_if {File.exists?("/etc/php5/fpm/pool.d/www.conf")}
  notifies :restart, "service[php5-fpm]"
end

log "Navigate to 'http://#{server_fqdn} to begin using Airtime. Login using User: admin Password: admin" do
  action :nothing
end

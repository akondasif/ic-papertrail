#
# Cookbook Name:: strongswan
# Description:: Installs l2tp ipsec support for StrongSwan server.
# Recipe:: masq
# Author:: Jerry Jackson (<jerry.w.jackson@gmail.com>)
#
# Copyright 2012, Infochimps
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
template( "/etc/rc.local" ) do
  source "rc.local.erb"
  notifies :run, 'execute[strongswan_masq]', :immediate
end

execute 'strongswan_masq' do
	command "iptables --table nat --append POSTROUTING --source #{node['strongswan']['ipsec']['tunable']['right']['subnet']} -j MASQUERADE"
	action :nothing
end
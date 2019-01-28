#
# Cookbook:: rails-server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# is vagrant?
# user = File.directory?("/home/vagrant") ?  "vagrant" : node['rails-server']['user']

# include_recipe 'git'

apt_update 'update' do
  action [:update]
end

apt_repository 'ruby2.4' do
  uri        'ppa:brightbox/ruby-ng'
end

# # update node version
# remote_file '/tmp/nodesource_setup.sh' do
#   source 'https://deb.nodesource.com/setup_6.x'
#   action :create
# end
#
# execute "update node resources" do
#     command "bash /tmp/nodesource_setup.sh"
# end

package 'nginx'

service 'nginx' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

template '/etc/nginx/sites-available/proxy.conf' do
  source 'proxy.conf.erb'
  variables proxy_port: node['nginx']['proxy_port']
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/proxy.conf' do
  to '/etc/nginx/sites-available/proxy.conf'
  notifies :restart, 'service[nginx]'
end

link '/etc/nginx/sites-enabled/default' do
  notifies :restart, 'service[nginx]'
  action :delete
end

include_recipe "nodejs"

nodejs_npm 'pm2'

package 'git-core'
package 'ruby2.4'
package 'ruby2.4-dev'
# package 'build-essential'
package 'libpq-dev'
package 'apt-transport-https'
package 'ca-certificates'

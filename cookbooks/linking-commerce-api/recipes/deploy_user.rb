group 'deploy' do
  action :create
end

user 'deploy' do
  comment 'Deploy User'
  gid 'deploy'
  home '/home/deploy'
  shell '/bin/bash'
  supports :manage_home => true
  action [ :create, :manage ]
end

directory '/home/deploy/.ssh' do
  owner 'deploy'
  group 'deploy'
  mode 0755
  action :create
  not_if { File.exists? '/home/deploy/.ssh' }
end

cookbook_file '/home/deploy/.ssh/id_rsa' do
  source 'id_rsa'
  owner 'deploy'
  group 'deploy'
  mode 0600
  action :create
end

cookbook_file '/home/deploy/.ssh/id_rsa.pub' do
  source 'id_rsa.pub'
  owner 'deploy'
  group 'deploy'
  mode  0600
  action :create
end

# cookbook_file '/home/deploy/.ssh/config' do
#   source 'config'
#   owner 'deploy'
#   group 'deploy'
#   mode 0600
#   action :create
# end

cookbook_file '/home/deploy/.ssh/authorized_keys' do
  source 'authorized_keys'
  owner 'deploy'
  group 'www-data'
  mode 0600
  action :create
end

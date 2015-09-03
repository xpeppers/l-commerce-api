node_name 'amazon'
local_mode true
cookbook_path ['.berks-cookbooks']

knife[:ssh_password] = "vagrant"
knife[:ssh_user] = "vagrant"
knife[:forward_agent] = true

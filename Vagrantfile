Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.box_check_update = true
  config.vm.network :private_network, ip:"192.168.33.100"

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.auto_detect = false
    config.cache.enable :gem
    config.cache.enable :chef_gem
    config.cache.enable :generic, { :cache_dir => "/var/chef/cache" }
  end

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = 1
    vb.memory = 1024
  end

  config.vm.provision :chef_zero, install: true, run: "always"  do |chef|
    chef.file_cache_path = '/var/chef/cache'
    chef.add_recipe "linking-commerce-api::default"
    chef.verbose_logging
  end

end

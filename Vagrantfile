Vagrant.configure("2") do |config|

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.auto_detect = false
    config.cache.enable :gem
    config.cache.enable :chef_gem
    config.cache.enable :generic, { :cache_dir => "/var/chef/cache" }
  end

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.provision :chef_zero, install: true, run: "always"  do |chef|
    chef.nodes_path = "cookbooks"
    chef.file_cache_path = '/var/chef/cache'
    chef.add_recipe "linking-commerce-api::default"
    chef.verbose_logging
  end

  config.vm.define "dev" do |dev|
    dev.vm.box = "ubuntu/trusty64"
    dev.vm.box_check_update = true
    dev.vm.network :private_network, ip:"192.168.33.100"

    dev.vm.provider "virtualbox" do |vb|
      vb.cpus = 1
      vb.memory = 1024
    end
  end

  config.vm.define "aws" do |aws|
    aws.ssh.username = "ubuntu"
    aws.ssh.private_key_path = "config/aws/linking-commerce.pem"

    aws.vm.box = "aws"
    aws.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

    ec2_token = JSON.parse(`aws sts get-session-token --duration-seconds 900`)

    aws.vm.provider :aws do |ec2, override|
      ec2.tags["Name"] = "Linking Commerce Api"

      ec2.access_key_id = ec2_token['Credentials']['AccessKeyId']
      ec2.secret_access_key = ec2_token['Credentials']['SecretAccessKey']
      ec2.session_token = ec2_token['Credentials']['SessionToken']

      ec2.keypair_name = "linking-commerce"
      ec2.subnet_id = "subnet-0230dc75"
      ec2.security_groups = [ "sg-e7d01c82" ]

      ec2.elastic_ip = true
      ec2.associate_public_ip = false

      ec2.region = "eu-west-1"
      ec2.ami = "ami-47a23a30"
      ec2.instance_type = "t2.small"

      override.nfs.functional = false
    end
  end

  config.vm.define "aws-vino" do |aws|
    aws.ssh.username = "ubuntu"
    aws.ssh.private_key_path = "config/aws/linking-commerce.pem"

    aws.vm.box = "aws"
    aws.vm.box_url = "https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box"

    ec2_token = JSON.parse(`aws sts get-session-token --duration-seconds 900`)

    aws.vm.provider :aws do |ec2, override|
      ec2.tags["Name"] = "Linking Commerce Wine Api"

      ec2.access_key_id = ec2_token['Credentials']['AccessKeyId']
      ec2.secret_access_key = ec2_token['Credentials']['SecretAccessKey']
      ec2.session_token = ec2_token['Credentials']['SessionToken']

      ec2.keypair_name = "linking-commerce"
      ec2.subnet_id = "subnet-0230dc75"
      ec2.security_groups = [ "sg-e7d01c82" ]

      ec2.elastic_ip = "54.77.111.102"
      ec2.associate_public_ip = false

      ec2.region = "eu-west-1"
      ec2.ami = "ami-47a23a30"
      ec2.instance_type = "t2.micro"

      override.nfs.functional = false
    end
  end

end

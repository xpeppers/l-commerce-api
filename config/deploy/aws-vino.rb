require 'json'

file = File.read('.vagrant/machines/aws-vino/aws/elastic_ip')
json = JSON.parse(file)
server_addr = json['public_ip']

set :stage, :production
set :rails_env, 'production'
set :rack_env, 'production'

role :app, [ "deploy@#{server_addr}" ]
role :web, [ "deploy@#{server_addr}" ]
role :db, [ "deploy@#{server_addr}" ]

server "#{server_addr}", user: 'deploy', roles: %w(db app web), primary: true

set :ssh_options, {
  forward_agent: false,
  keys: %w(config/deploy/ssh/keys/id_rsa),
  auth_methods: %w(publickey),
  config: 'config/deploy/ssh/config'
}

set :keep_releases, 5

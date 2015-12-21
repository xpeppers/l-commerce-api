require 'json'

file = File.read('.vagrant/machines/aws/aws/elastic_ip')
json = JSON.parse(file)
server_addr = json['public_ip']

set :stage, :production
set :rails_env, 'production'
set :rack_env, 'production'

role :app, [ "deploy@#{server_addr}" ]
role :web, [ "deploy@#{server_addr}" ]
role :db, [ "deploy@#{server_addr}" ]

server "#{server_addr}", user: 'deploy', roles: %w(db app web), primary: true

set :default_env, {
  'ASSET_HOST' => "http://#{server_addr}"
}

set :ssh_options, {
  forward_agent: false,
  keys: %w(config/deploy/ssh/keys/id_rsa),
  auth_methods: %w(publickey),
  config: 'config/deploy/ssh/config'
}

set :keep_releases, 5

namespace :deploy do
  task :config_reseller do
    on roles(:app) do
      execute :cp, "#{release_path}/config/facebook-tdv.yml #{release_path}/config/facebook.yml"
      execute :cp, "#{release_path}/config/paypal-tdv.yml #{release_path}/config/paypal.yml"
      execute :cp, "#{release_path}/config/linkingcommerce-tdv.yml #{release_path}/config/linkingcommerce.yml"
    end
  end
end

after 'deploy:updating', 'deploy:config_reseller'

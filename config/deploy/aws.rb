set :stage, :production
set :rails_env, 'production'

role :app, %w{deploy@52.18.177.199}
role :web, %w{deploy@52.18.177.199}
role :db, %w{deploy@52.18.177.199}

server '52.18.177.199', user: 'deploy', roles: %w(db app web), primary: true

set :ssh_options, {
  forward_agent: false,
  keys: %w(config/deploy/ssh/keys/id_rsa),
  auth_methods: %w(publickey),
  config: 'config/deploy/ssh/config'
}

set :keep_releases, 5

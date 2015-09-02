set :stage, :development
set :rails_env, 'development'

# set :unicorn_pid, -> { File.join(shared_path, "tmp", "pids", "unicorn.pid") }

role :app, %w{deploy@192.168.33.100}
role :web, %w{deploy@192.168.33.100}
role :db, %w{deploy@192.168.33.100}

server '192.168.33.100', user: 'deploy', roles: %w(db app web), primary: true

set :ssh_options, {
  forward_agent: false,
  keys: %w(config/deploy/ssh/keys/id_rsa),
  auth_methods: %w(publickey),
  config: 'config/deploy/ssh/config'
}

set :keep_releases, 1

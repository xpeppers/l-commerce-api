set :application, 'linking-commerce-api'
set :repo_url, 'git@github.com:xpeppers/linking-commerce-api.git'

set :deploy_to, '/home/deploy/'

set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, false # sets a non-login, non-interactive shell

# set :linked_files, %w{config/database.yml .env}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle}

set :keep_releases, 5
set :bundle_without, "development test deploy"

set :foreman_env, '/dev/null'

namespace :deploy do
  before :publishing, 'db:seed_fu'
  after :publishing, 'foreman:restart'
  after :finishing, 'deploy:cleanup'
end

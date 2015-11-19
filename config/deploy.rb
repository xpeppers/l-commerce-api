set :application, 'linking-commerce-api'
set :repo_url, 'git@github.com:xpeppers/linking-commerce-api.git'

set :deploy_to, '/home/deploy/'

set :scm, :git
set :format, :pretty
set :log_level, :debug
set :pty, false # sets a non-login, non-interactive shell

set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/uploads}

set :keep_releases, 5
set :bundle_without, "development test deploy"

set :unicorn_pid, -> { File.join(shared_path, "tmp", "pids", "unicorn.pid") }
set :unicorn_config_path, -> { File.join(current_path, "config", "unicorn.rb") }


namespace :deploy do
  desc "Restart Unicorn"
  task :unicorn_restart do
    invoke 'unicorn:stop'
    sleep 3
    invoke 'unicorn:start'
  end

  after :publishing, :unicorn_restart
  after :finishing, 'deploy:cleanup'
end

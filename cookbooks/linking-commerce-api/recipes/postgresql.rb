file "remove deprecated pitti-ppa apt repository" do
  action :delete
  path "/etc/apt/sources.list.d/pitti-postgresql-ppa"
end

bash "adding postgresql repo" do
  user "root"
  code <<-EOC
  echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
  EOC
  action :run
end

execute "run apt-get update" do
  command 'apt-get update'
  action :run
end

packages = %w{libpq-dev postgresql-contrib postgresql-9.3}
packages.each { |name| package name }

db_user = db_name = db_pass = 'linking_commerce'

bash "create linking-commerce postgres user and database" do
  code <<-EOC
  psql -c "CREATE ROLE #{db_user} UNENCRYPTED PASSWORD '#{db_pass}' NOSUPERUSER CREATEDB NOCREATEROLE INHERIT LOGIN;"
  psql -c "CREATE DATABASE #{db_name} OWNER #{db_user};"
  EOC
  user "postgres"
  ignore_failure true
  action :run
end

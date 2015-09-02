include_recipe "ruby-ng::dev"

include_recipe "postgresql::server"
include_recipe "database::postgresql"

db_root_user = 'postgres'
db_root_pass = node['postgresql']['password']['postgres']

db_user = 'linking-commerce'
db_name = 'linking-commerce'
db_pass = 'linking-commerce'

connection_info = {
  :host      => '127.0.0.1',
  :port      => 5432,
  :username  => db_root_user,
  :password  => db_root_pass
}

postgresql_database_user db_user do
  connection connection_info
  password db_pass
  action :create
end

postgresql_database db_name do
  connection connection_info
  owner db_user
  action :create
end

postgresql_database_user db_user do
  connection connection_info
  database_name db_name
  privileges [:all]
  action :grant
end


include_recipe "linking-commerce-api::users"
package "git-core"

# %w{git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev}


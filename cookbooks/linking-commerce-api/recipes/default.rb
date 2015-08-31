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

postgresql_database db_name do
  connection connection_info
  action :create
end

postgresql_database_user db_user do
  connection connection_info
  password db_pass
  database_name db_name
  action :create
end

include_recipe "linking-commerce-api::deploy_user"

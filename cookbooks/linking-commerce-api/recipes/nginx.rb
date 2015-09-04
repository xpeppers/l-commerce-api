include_recipe 'nginx'

cookbook_file '/etc/nginx/sites-available/linking-commerce-api' do
  source 'linking-commerce-api.nginx'
  action :create
end

link '/etc/nginx/sites-enabled/linking-commerce-api' do
  to '/etc/nginx/sites-available/linking-commerce-api'
end

link '/etc/nginx/sites-enabled/000-default' do
  action :delete
end

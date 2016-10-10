# packages = %w{git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev}
# packages.each { |name| package name }

packages = %w{git-core libsqlite3-dev}
packages.each { |name| package name }

include_recipe "ruby-ng::default"
include_recipe "ruby-ng::dev"
include_recipe "timezone-ii::default"

include_recipe "linking-commerce-api::postgresql"
include_recipe "linking-commerce-api::users"
include_recipe "linking-commerce-api::nginx"

execute 'install chef-dk' do
  command 'curl https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chefdk_0.7.0-1_amd64.deb -L -O && dpkg -i chefdk_0.7.0-1_amd64.deb'
  not_if 'command -v chef >/dev/null 2>&1 && chef verify'
end

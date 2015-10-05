require File.expand_path('../boot', __FILE__)

require 'rails/all'
require 'carrierwave'
require 'carrierwave/orm/activerecord'

Bundler.require(*Rails.groups)

module LinkingCommerceApi
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib')
    config.active_record.raise_in_transactional_callbacks = true
    config.asset_host = 'http://127.0.0.1:3000/'
  end
end

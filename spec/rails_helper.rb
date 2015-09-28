ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'spec_helper'
require 'rspec/rails'

Dir[Rails.root.join('spec', 'support', '*.rb')].each {|f| require f}

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.filter_run_excluding integration: true unless ENV['ALL']

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.include FactoryGirl::Syntax::Methods

  config.include JsonSpec::Helpers, type: :controller
end

JsonSpec.configure do
  exclude_keys "created_at", "updated_at"
end

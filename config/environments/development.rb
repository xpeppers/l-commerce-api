Rails.application.configure do

  config.cache_classes = false

  config.eager_load = false

  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false

  config.action_mailer.raise_delivery_errors = false

  config.active_support.deprecation = :log

  config.active_record.migration_error = :page_load

  config.assets.debug = true

  config.assets.digest = true

  config.assets.raise_runtime_errors = true

  config.asset_host = 'http://127.0.0.1:3000'

  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default :charset => "utf-8"
  config.action_mailer.smtp_settings = {
      :address => "smtp.gmail.com",
      :port => 587,
      :domain => 'localhost:3000',
      :user_name => "youraccount@yourdomain.com",
      :password => "yourpassword",
      :authentication => :plain,
      :enable_starttls_auto => true
  }

end

BCRYPT_SALT = '$2a$10$z8SblQIXs7Bp3/xCinvjKO'

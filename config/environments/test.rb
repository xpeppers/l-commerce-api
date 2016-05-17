Rails.application.configure do

  config.cache_classes = true

  config.eager_load = false

  config.serve_static_files   = true
  config.static_cache_control = 'public, max-age=3600'

  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  config.action_dispatch.show_exceptions = false

  config.action_controller.allow_forgery_protection = false

  config.action_mailer.delivery_method = :test

  config.active_support.test_order = :random

  config.active_support.deprecation = :stderr

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

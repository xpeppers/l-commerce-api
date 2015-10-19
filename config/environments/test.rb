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
end

BCRYPT_SALT = '$2a$10$z8SblQIXs7Bp3/xCinvjKO'

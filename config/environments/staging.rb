Closetgroupie::Application.configure do
  config.base_url = "http://staging.closetgroupie.com"
  config.root_uri = "staging.closetgroupie.com"

  config.paypal = {
    :login     => "joonas_1338321438_biz_api1.closetgroupie.com",
    :password  => "1338321463",
    :signature => "AM1nJUGwQaq7jopNFOUMd8.hX-JkAZkj2yWQWtTN4LFdRzW7m2sJPokS",
    :appid     => "APP-80W284485P519543T",
    :email     => "joonas_1338321438_biz@closetgroupie.com"
  }

  config.facebook = {
    :key    => 318393408253850,
    :secret => "cd845298813252ac18cd6e22f5bdbb92"
  }

  config.og_namespace = 'closetgroupie-stagin'

  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.asset_host = "http://staging.closetgroupie.com"
  config.action_controller.asset_host = "http://staging.closetgroupie.com"
  config.action_controller.default_url_options = {
    :host => "staging.closetgroupie.com"
  }

  # So emails can be viewed locally
  config.action_mailer.delivery_method = :file
  config.action_mailer.file_settings = { :location => Rails.root.join('tmp/mail') }
  config.action_mailer.default_url_options = {
    :host => "staging.closetgroupie.com"
  }

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  config.serve_static_assets = false
  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Generate digests for assets URLs
  config.assets.digest = true

  config.assets.precompile += %w( search.js activity.js shop.js item.js add-items.js infinite-scroll.js filters.js closets.js activities.js landing.css active_admin.css active_admin.js error.css )

  # Do not compress assets
  # config.assets.compress = false

  # Expands the lines which load the assets
  # config.assets.debug = true
end

ActiveMerchant::Billing::Base.mode = :test

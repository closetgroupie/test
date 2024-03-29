Closetgroupie::Application.configure do
  config.base_url = "https://closetgroupie.com"
  config.root_uri = "closetgroupie.com"

  config.paypal = {
    :login     => "kelly_api1.closetgroupie.com",
    :password  => "J2WBX3X8262PZB6N",
    :signature => "AFcWxV21C7fd0v3bYYYRCpSSRl31AlNa3EBBJOYs2XQDOwRUn5NPBM5B",
    :appid     => "APP-6GS31579W6058502N",
    :email     => "kelly@closetgroupie.com"
  }

  config.facebook = {
    :key    => 195906460469934,
    :secret => "3c11385cf4f9036acb5acd8274028d80"
  }
  config.og_namespace = 'closetgroupie'

  # Settings specified here will take precedence over those in config/application.rb
  config.action_mailer.delivery_method = :smtp

  config.action_mailer.default_url_options = {
    :host     => config.root_uri,
    :protocol => "https"
  }

  # config.action_mailer.smtp_settings = {
  #   :address              => "in.mailjet.com",
  #   :port                 => 587,
  #   :authentication       => :plain,
  #   :user_name            => "6efee03e1cb2ac9a6ffa0e21f55aec74",
  #   :password             => "e31a8afe66db1d72a0ce0a293d5812ef",
  #   :enable_starttls_auto => true
  # }

  config.action_mailer.smtp_settings = {
    :address              => "smtp.sendgrid.net",
    :port                 => 587,
    :authentication       => :plain,
    :user_name            => "closetgroupie",
    :password             => "HdYL72bNouEmYseiGRUG",
    :domain               => "closetgroupie.com",
    :enable_starttls_auto => true
  }

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false
  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = true

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Generate digests for assets URLs
  config.assets.digest = true

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Specifies the header that your server uses for sending files
  # config.action_dispatch.x_sendfile_header = "X-Sendfile" # for apache
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect' # for nginx

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  # config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Prepend all log lines with the following tags
  # config.log_tags = [ :subdomain, :uuid ]

  # Use a different logger for distributed setups
  # config.logger = ActiveSupport::TaggedLogging.new(SyslogLogger.new)

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # TODO: This needs to be switched out to the CDN once we have one.
  config.action_controller.asset_host = config.base_url
  config.action_mailer.asset_host = config.action_controller.asset_host

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  config.assets.precompile += %w( search.js activity.js shop.js item.js add-items.js infinite-scroll.js filters.js closets.js activities.js landing.css active_admin.css active_admin.js become-a-curator.js error.css )

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  config.action_mailer.default_url_options = { host: "closetgroupie.com" }

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5
end

source 'https://rubygems.org'

gem 'rails', '3.2.6'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'

group :production do
  gem 'newrelic_rpm'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'compass-rails'
  gem 'compass'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes

  gem 'uglifier', '>= 1.0.3'
end

gem 'therubyracer'

group :development, :test do
  #gem 'pry'
  #gem 'pry-remote'
  #gem 'letter_opener'
  #gem 'acts-as-importable', github: "kweightman/acts-as-importable"
  #gem 'capybara'
  #gem 'rspec-rails'
  #gem 'launchy'
  #gem 'factory_girl_rails', :require => false
  #gem 'guard-rspec'
  #gem 'spork'
  #gem 'capybara-webkit'
end

gem 'jquery-rails'
gem 'ejs'
gem 'rabl'

gem 'tire'
gem 'kaminari'

gem 'hiredis'
gem 'redis'

gem 'sorcery'
gem 'dynamic_form'
gem 'wicked'
gem 'faraday'

gem 'activemerchant', :require => 'active_merchant'

# We're using the github trunk until they release 0.3.14
# with the fix for SSLError
gem 'active_paypal_adaptive_payment', :github => 'jpablobr/active_paypal_adaptive_payment'

# gem 'activerecord-postgres-hstore'

# Provides ISO 3166-1 alpha-2 code / country name select
gem 'country_code_select'

gem 'mini_magick'
gem 'carrierwave'

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
group :deployment do
  gem 'rvm-capistrano'
  gem 'capistrano'
  gem 'capistrano-ext'
end

# Facebook Graph API
gem 'koala'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

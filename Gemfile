source 'https://rubygems.org'
ruby '2.0.0'

gem 'rails', '3.2.6'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
group :production do
  gem 'pg',             '0.17.1'
  gem 'rails_12factor', '0.0.2'
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

group :development, :test do
  gem 'pry'
  #gem 'pry-remote'
  #gem 'letter_opener'
  #gem 'irbtools'
  #gem 'acts-as-importable', github: "kweightman/acts-as-importable"
  #gem 'capybara'
  #gem 'rspec-rails'
  #gem 'launchy'
  #gem 'factory_girl_rails', :require => false
  #gem 'guard-rspec'
  #gem 'spork'
  #gem 'capybara-webkit'
end

group :development, :test, :staging do
  # Seed data generation
  gem 'ffaker'
end

group :staging do
  gem 'compass'
  gem 'compass-rails'
end

gem 'client_side_validations'

gem 'jquery-rails'
gem 'ejs'
gem 'grape'
gem 'rabl'

gem 'tire'
gem 'kaminari'

gem 'activeadmin', github: 'joonas/active_admin'
gem 'meta_search'

gem 'hiredis'
gem 'redis'
gem 'sidekiq'

# Exception handling, exceptional.io
gem 'exceptional'

# UUID generation
gem 'uuidtools'

# For now, we'll just use sorcery for this, because it's simpler than migrating
# gem 'omniauth-identity'
gem 'omniauth-facebook'
gem 'sorcery', '~> 0.7.12'

gem 'dynamic_form'
gem 'wicked'

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

gem 'whenever', :require => false

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

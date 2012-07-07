OmniAuth.configure do |config|
  config.path_prefix = '/connect'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  # TODO: Move these in to ENVironment variables
  facebook_key = Closetgroupie::Application.config.facebook[:key]
  facebook_secret = Closetgroupie::Application.config.facebook[:secret]

  # provider :identity, :model => User, :on_failed_registration => lambda { |env|
  #          SessionsController.action(:new).call(env)
  # } # :fields => [:email]
  provider :facebook, facebook_key, facebook_secret, :display => 'page',
           :scope => 'email', :image_size => 'large'
end

OmniAuth.configure do |config|
  config.path_prefix = '/connect'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  # TODO: Move these in to ENVironment variables
  if Rails.env.development?
    facebook_key = "241246552660833"
    facebook_secret = "b916fb1ecf5800938015fab4e2fb93e2"
  else
    facebook_key = "195906460469934"
    facebook_secret = "3c11385cf4f9036acb5acd8274028d80"
  end

  # provider :identity, :model => User, :on_failed_registration => lambda { |env|
  #          SessionsController.action(:new).call(env)
  # } # :fields => [:email]
  provider :facebook, facebook_key, facebook_secret, :display => 'page',
           :scope => 'email,publish_actions', :image_size => 'large'
end

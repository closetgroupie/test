OmniAuth.configure do |config|
  config.path_prefix = '/connect'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity, :model => User, :on_failed_registration => lambda { |env|
           SessionsController.action(:new).call(env)
  } # :fields => [:email]
  provider :facebook, 241246552660833, "b916fb1ecf5800938015fab4e2fb93e2",
           :scope => 'email', :display => 'page'
end

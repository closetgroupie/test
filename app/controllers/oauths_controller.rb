class OauthsController < ApplicationController
  include OauthsHelper

  skip_before_filter :require_login
      
  # sends the user on a trip to the provider,
  # and after authorizing there back to the callback url.
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    begin
      if @user = login_from(provider)
        token = @provider.access_token.token
        persist_facebook_access_token(@user, token) if provider == 'facebook'
        redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
      else
          @user = create_from(provider)
          token = @provider.access_token.token
          persist_facebook_access_token(@user, token) if provider == 'facebook'

          # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule

          reset_session # protect from session fixation attack
          auto_login(@user)
          redirect_to root_path, :notice => "Logged in from #{provider.titleize}!"
      end
    rescue
      # TODO better error handling so we can post-mortem if
      # something goes wrong
      redirect_to root_path, :alert => "Failed to login from #{provider.titleize}!"
    end
  end
end

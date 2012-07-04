class SocialRegistrationsController < ApplicationController
  before_filter :require_no_login

  def new
    # TODO: Make use of the facebook cookie if it's present
    # user_info = @oauth.get_user_info_from_cookies(cookies)

    # Initiate Koala oauth
    @oauth = Koala::Facebook::OAuth.new(
      facebook_credentials[:key],
      facebook_credentials[:secret],
      social_signup_url
    )

    # Get code if it's not present
    return redirect_to @oauth.url_for_oauth_code unless params[:code].present?

    # Attempt to convert the code to an access_token and fetch the user's info
    begin
      @oauth_access_token = @oauth.get_access_token params[:code].to_s
      graph = Koala::Facebook::API.new(@oauth_access_token)
      @me   = graph.get_object("me")

      return redirect_to connect_path(provider: "facebook") if Authentication.find_by_uid_and_provider(@me.fetch('id', ''), 'facebook')

      session[:oauth_token] = @oauth_access_token
    rescue Koala::Facebook::APIError => ex
      # TODO: Log errors? Redirect somewhere else? Set a flash notification?
      return redirect_to root_url
    # TODO: Rescue from if graph the requests to facebook timeout, or Koala::Facebook::API raises an error
    # rescue Koala::Facebook...?
    end

    if @me.present?
      @user = User.new
      @me.slice("name", "email", "gender").each do |key, value|
        @user.send("#{key}=", value)
      end
      @avatar_url = "https://graph.facebook.com/#{@me.fetch('id', '')}/picture?type=large"
    else
      # TODO: Can we handle this better elsewhere, maybe set a flash message?
      return redirect_to root_url
    end
  end

  def create
    # @avatar_url, @oauth_access_token, @uid = params[:user].extract!(:avatar, :access_token, :uid).values
    access_token = session[:oauth_token]
    graph = Koala::Facebook::API.new(access_token)
    @me   = graph.get_object("me")

    @avatar_url = "https://graph.facebook.com/#{@me.fetch('id', '')}/picture?type=large"

    @user = User.new(params[:user])
    @user.authentications.build({
      provider: "facebook",
      uid: @me.fetch("id", nil),
      access_token: access_token
    })

    if @user.valid?
      auto_login(@user) if @user.save
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def facebook_credentials
    @facebook_credentials ||= Closetgroupie::Application.config.facebook
  end

  def require_no_login
    return redirect_to "/" if current_user
  end
end

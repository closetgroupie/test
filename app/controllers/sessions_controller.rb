class SessionsController < ApplicationController
  before_filter :allow_only_unauthorized, only: [:new, :create]

  def new
  end

  def create
    if auth_hash.present?
      user = User.from_omniauth(auth_hash)
      if user.present?
        session[:user_id] = user.id
      else
        return redirect_to social_signup_path
      end
    elsif user = legacy_login(params[:email], params[:password])
      user.update_attributes({
        password: params[:password],
        legacy_password: nil
      })
    else
      user = login(params[:email], params[:password], params[:remember_me])
    end

    if user
      redirect_back_or_to root_url #, :notice => "Logged in!"
    else
      flash.now.alert = "E-mail or password was invalid."
      render :new
    end
  end

  def destroy
    # TODO: Once we have remember me functionality, we need to delete the cookie here.
    logout
    redirect_to root_url#, :notice => "Logged out!"
  end

  def failure
  end

private

  def allow_only_unauthorized
    return redirect_to root_url if current_user
  end

  def callback
    auth = Authentication.where(auth_hash.slice('provider', 'uid')).first
    binding.pry
    raise auth_hash.to_yaml
  end

  def auth_hash
    request.env['omniauth.auth']
  end
end

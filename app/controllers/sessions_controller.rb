class SessionsController < ApplicationController
  before_filter :allow_only_unauthorized, only: [:new, :create]

  def new
  end

  def create
    if user = legacy_login(params[:email], params[:password])
      user.update_attributes({
        password: params[:password],
        legacy_password: nil
      })
    end

    user = login(params[:email], params[:password], params[:remember_me])

    if user
      redirect_back_or_to root_url #, :notice => "Logged in!"
    else
      flash.now.alert = "E-mail or password was invalid."
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url#, :notice => "Logged out!"
  end

private

  def allow_only_unauthorized
    return redirect_to root_url if current_user
  end
end

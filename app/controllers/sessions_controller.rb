class SessionsController < ApplicationController
  def new
  end

  def create
    # redirect_to :back, :alert => "Log in has been disabled for right now, while we work out some bugs on the site. We will be back as soon as possible. We are sorry for the inconvenience. Thanks, Joonas & Kelly"
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
    puts "done1"
    redirect_to root_url#, :notice => "Logged out!"
    puts "done2"
  end
end

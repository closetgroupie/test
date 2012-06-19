class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  def create
    @user = User.find_by_email(params[:email])

    if @user
      @user.deliver_reset_password_instructions!
      redirect_to login_path, :notice => "Instructions on how to reset your password have been sent to your email."
    else
      flash.now.alert = "No account exists for #{params[:email]}, maybe you used a different e-mail or entered incorrect address."
      render :new
    end
  end

  def edit
    @user = User.load_from_reset_password_token(params[:id])
    @token = params[:id]
    not_authenticated unless @user
  end

  def update
    @token = params[:token]
    @user = User.load_from_reset_password_token(params[:token])
    not_authenticated unless @user
    # the next line makes the password confirmation validation work
    @user.password_confirmation = params[:user][:password_confirmation]
    # the next line clears the temporary token and updates the password
    if @user.change_password!(params[:user][:password])
      # TODO: Should we just log the user in?
      # auto_login(@user)
      # TODO: Send an e-mail about password being reset?
      redirect_to(login_path, :notice => 'Password was successfully updated.')
    else
      render :edit
    end
  end
end

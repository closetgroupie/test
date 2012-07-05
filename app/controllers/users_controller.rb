class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      auto_login(@user)
      redirect_to root_url #, :notice => "Signed up!"
    else
      # TODO: Errors?
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end
end

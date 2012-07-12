class CuratorApplicationsController < ApplicationController
  # before_filter :require_login

  def new
    @application = CuratorApplication.new
  end

  def create
    @application = CuratorApplication.new(params[:curator_application])
    @application.user_id = current_user.id if current_user
    if @application.save
      redirect_to root_url, :notice => "Thank you for your submission, we will get in touch with you soon."
    else
      render :new
    end
  end
end

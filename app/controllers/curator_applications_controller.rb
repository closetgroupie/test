class CuratorApplicationsController < ApplicationController
  # before_filter :require_login

  def new
    @application = CuratorApplication.new
  end

  def create
    @application = CuratorApplication.new(params[:curator_application])
    if @application.valid?

    else
      render :new
    end
  end
end

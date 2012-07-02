class OrdersController < ApplicationController
  layout "dashboard"

  before_filter :require_login

  def index
    @orders = current_user.sales
  end

  def show
    @order = current_user.sales.find(params[:id])
  end
end

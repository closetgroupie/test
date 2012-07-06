class PurchasesController < ApplicationController
  # This is a controller that shows purchased carts
  layout "dashboard"

  before_filter :require_login

  def index
    @purchases = Cart.purchases_by(current_user)
  end

  def show
    @purchase = current_user.purchases.find(params[:id])
  end
end

class PurchasesController < ApplicationController
  # This is a controller that shows purchased carts
  layout "dashboard"

  def index
    @purchases = Cart.purchases_by(current_user)
  end

  def show
    # TODO: current_user.purchases.find(params[:id])
    
    # TODO: TRES: make sure only current user can access before merge
    #@purchase = Cart.where(user_id: current_user.id, id: params[:id]).first
    @purchase = Order.find(params[:id]).cart
  end
end

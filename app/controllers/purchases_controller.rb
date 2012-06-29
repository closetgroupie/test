class PurchasesController < ApplicationController
  # This is a controller that shows purchased carts
  layout "dashboard"

  def index
    @purchases = Cart.purchases_by(current_user)
  end

  def show
    # TODO: current_user.purchases.find(params[:id])
    purchase = Cart.find params[:id]
    if purchase.user_id != current_user.id
      raise ActionController::RoutingError.new('Forbidden')
    else
      @purchase = purchase
    end
  end
end

class OrdersController < ApplicationController
  layout "dashboard"

  before_filter :require_login

  def index
    type = params.fetch(:type, :purchases)
    @orders = case type
              when :purchases
                Order.purchases_by(current_user)
              when :sales
                Order.sales_by(current_user)
              end
    render type
  end

  def show
    type = params.fetch(:type, :purchases)
    @order = case type
             when :purchases
               order = Order.where(id: params[:id]).first
               if order.buyer_id != current_user.id
                 raise ActionController::RoutingError.new('Forbidden')
               else
                 order
               end
             when :sales
               order = Order.find params[:id]
               if current_user.id != order.seller_id
                 raise ActionController::RoutingError.new('Forbidden')
               else
                 order
               end
             end
  end
end

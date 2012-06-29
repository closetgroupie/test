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
    binding.pry
    @order = case type
             when :purchases
               # TODO TRES restrict to current user before merge
               #Order.where(id: params[:id]).first
               o = Order.where(id: params[:id], buyer_id: current_user.id).first
               binding.pry
             when :sales
               # TODO TRES restrict to current user before merge
               # TODO: Check permissions, make seller_id instead of buyer_id
               #Order.where(id: params[:id]).first
               o = Order.where(id: params[:id], seller_id: current_user.id).first
               binding.pry
             end
    render type
  end
end

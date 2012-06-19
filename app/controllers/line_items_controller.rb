class LineItemsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    unless @item.belongs_to_any_cart?
      current_cart.line_items.create(item_id: @item.id, price: @item.price)
      redirect_to cart_url, :notice => "Item added to cart."
    else
      redirect_to @item, :alert => "Someone is already buying this item."
    end
  end

  def destroy
    @line_item = current_cart.line_items.find(params[:id])
    if @line_item.delete
      # TODO: redirect_to :back instead and rescue?
      redirect_to cart_path, :notice => "Successfully removed item from cart"
    else
      redirect_to root_path, :alert => "Unable to remove item from cart, please try again."
    end
  end
end

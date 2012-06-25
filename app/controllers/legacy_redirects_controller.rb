class LegacyRedirectsController < ApplicationController
  def item_details
    item = Item.find_by_legacy_id(params[:legacy_id])
    if item.present?
      redirect_to item_path(item), :status => 301
    else
      raise not_found
    end
  end

  def closet
    closet = Closet.find_by_legacy_id(params[:legacy_id])
    if closet.present?
      redirect_to closet_path(closet), :status => 301
    else
      raise not_found
    end
  end

  private

  def not_found
    return ActionController::RoutingError.new("Not Found")
  end
end

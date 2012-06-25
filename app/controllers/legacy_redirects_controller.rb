class LegacyRedirectsController < ApplicationController
  def item_details
    item = Item.find_by_legacy_id(params[:legacy_id])
    if item.present?
      redirect_to item_path(item), :status => 301
    else
      raise ActionController::RoutingError.new("Not Found")
    end
  end
end

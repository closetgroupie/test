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

  def item_image
    if params[:image].present?
      if params[:image].match(/_/)
        bits = params[:image].split('_')
        name = bits[0]
      else
        name = params[:image].split('.')[0]
      end

      image = "#{name}.#{params[:format]}"
      item_id = params[:item].to_i

      photo = Photo.includes(:item).where("items.legacy_id = ? AND photos.original_name = ?", item_id, image).first

      if photo.present?
        redirect_to photo.image_url(:thumbnail), :status => 301
      else
        raise not_found
      end
    end
  end

  private

  def not_found
    return ActionController::RoutingError.new("Not Found")
  end
end

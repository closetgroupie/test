class FavoritesController < ApplicationController
  before_filter :find_favorite_item, except: :index
  before_filter :require_login

  def index
    @favorites = current_user.favorites
  end

  def create
    @favorite = current_user.favorites.create({ item_id: @item.id })
    respond_to do |format|
      format.html do 
        begin
          redirect_to :back
        rescue ActionController::RedirectBackError
          redirect_to @item
        end
      end
      format.js
    end
  end

  def destroy
    favorite = current_user.favorites.find_by_item_id(@item)
    if favorite.persisted?
      Favorite.destroy(favorite.id)
    end
    redirect_to :back
  end

  private

  def find_favorite_item
    @item = Item.find(params[:id])
  end
end

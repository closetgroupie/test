class ActivitiesController < ApplicationController
  def index
    @favorites = get_user_favorites()
    @activities = Activity.includes(:user, :entity => [:hero_image]).limit(40)
  end

  def feed
    @favorites = get_user_favorites()
    if params.has_key?(:since)
      @activities = Activity.includes(:user, :entity => [:hero_image]).since(params[:since].to_i).limit(40)
    elsif params.has_key?(:before)
      @activities = Activity.includes(:user, :entity => [:hero_image]).before(params[:before].to_i).limit(40)
    else
      @activities = Activity.includes(:user, :entity => [:hero_image]).limit(40)
    end

    respond_to :json
  end

  def previous
    @activities = Activity.since_id(params[:id].to_s)
    render "previous", :layout => false
  end

  private

  def get_user_favorites()
    return current_user ? current_user.favorites.pluck(:item_id) : []
  end
end

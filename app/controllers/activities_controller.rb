class ActivitiesController < ApplicationController
  def index
    @activities = Activity.latest
  end

  def previous
    @activities = Activity.since(params[:id].to_s)
    render "previous", :layout => false
  end
end

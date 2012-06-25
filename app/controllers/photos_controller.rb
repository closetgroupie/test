class PhotosController < ApplicationController
  before_filter :require_login, :require_admin

  def rotate_clockwise
    @photo = Photo.find(params[:id])
    @photo.rotate!(90)
    redirect_to :back
  end

  def rotate_counterclockwise
    @photo = Photo.find(params[:id])
    @photo.rotate!(-90)
    redirect_to :back
  end
end

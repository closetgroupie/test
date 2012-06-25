class PhotosController < ApplicationController
  def rotate_clockwise
    @photo = Photo.find(params[:id])
    @photo.rotate!(90)
  end

  def rotate_counterclockwise
    @photo = Photo.find(params[:id])
    @photo.rotate!(-90)
  end
end

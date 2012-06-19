class StaticController < ApplicationController
  def show
    respond_to do |format|
      format.html
    end
  end
  
  def method_missing(method, *args)
    show
  end
end

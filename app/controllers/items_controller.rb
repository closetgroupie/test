class ItemsController < ApplicationController
  layout "dashboard", except: [:show]

  before_filter :require_login, :except => [:show]

  def new
    @item = Item.new
    5.times { @item.photos.build }
    # TODO: Domain models
    @segments = Segment.all
    @categories = Category.all
    @sizes = Size.all
  end

  def create
    @item = current_user.items.build(params[:item])
    @item.closet = current_user.closet
    if @item.save
      redirect_to item_url(@item), :notice => "Item created successfully."
    else
      # TODO: Errors
      render :new
    end
  end

  def edit
    @item = current_user.items.includes(:photos).find(params[:id])
    remaining_photo_slots = 5 - @item.photos.size
    remaining_photo_slots.times { @item.photos.build }
    @segments = Segment.all
    @categories = Category.all
    @sizes = Size.all
  end

  def update
    @item = current_user.items.find(params[:id])
    # TODO: Check the whitelisting here..
    if @item.update_attributes(params[:item])
      redirect_to @item, :notice => "Updated item successfully."
    else
      remaining_photo_slots = 5 - @item.photos.size
      remaining_photo_slots.times { @item.photos.build }
      @segments = Segment.all
      @categories = Category.all
      @sizes = Size.all
      render :edit
    end
  end

  def destroy
    @item = current_user.items.find(params[:id])
    @item.destroy
    # TODO: Unless user is admin?
    redirect_to current_user.closet
  end

  def show
    @item = Item.find(params[:id])
  end

  def selling
    @items = current_user.items.selling
  end

  def sold
    @items = current_user.items.sold
  end
end

class ClosetsController < ApplicationController
  def index
    # TODO: Filter to show only those that have items, initially
    @closets = Closet.limit(40)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show
    @closet = Closet.find(params[:id])
  end

  def following
    @closets = Closet.followed_by(current_user)
    render :index
  end

  def friends
    # TODO: Fetch user's friends
    # @closets = Closet.friends_with(current_user)
    @closets = []
    render :index
  end

  def reviews
  end
end

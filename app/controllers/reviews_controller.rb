class ReviewsController < ApplicationController
  # TODO: Ensure, for new and create actions, that user can actually review,
  # (i.e. they purchased from them) and that they are NOT the closet owner

  def index
    @closet = get_closet(params[:closet_id])
    @reviews = @closet.reviews.includes(:user)
  end

  def new
    @closet = get_closet(params[:closet_id])
    @review = Review.new
  end

  def create
    closet = get_closet(params[:closet_id])
    review = closet.reviews.build(params[:review])
    review.user = current_user
    if review.save
      redirect_to closet_reviews_path(closet),
        :notice => "Thanks for reviewing #{closet.user.name}"
    else
      redirect_to closet_reviews_path(closet),
        :alert => "Could not review #{closet.user.name}, please try again."
    end
  end

  private

    def get_closet(closet_id)
      Closet.includes(:user).find(closet_id)
    end
end

class Closet < ActiveRecord::Base
  belongs_to :user
  has_many :items
  has_many :reviews

  attr_accessible :name, :user_id

  def self.followed_by(user)
    followed_users = user.followings.pluck(:target_id)
    where(:user_id => followed_users).includes(:user)
  end

  def self.following(user)
    groupies = user.groupies.pluck(:user_id)
    where(:user_id => groupies).includes(:user)
  end

  # Used by closets#friends
  def self.friends_with(user)
    # TODO: Filter by friends
  end

  def can_be_reviewed_by_user?(reviewer)
    # TODO: Refactor, move to a PORO
    orders_between_users = Order.between(reviewer, user)
    reviews_by_user = Review.made_by(reviewer)

    orders_between_users.size > reviews_by_user.size
  end
end

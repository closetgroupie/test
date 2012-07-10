class Review < ActiveRecord::Base
  attr_accessible :content

  belongs_to :closet
  belongs_to :user

  def self.made_by(user_id)
    where(:user_id => user_id)
  end

  def self.made_by_buyer_for_closet(buyer_id, closet_id)
    buyer_reviews = Set.new(self.made_by(buyer_id))
    closet_reviews = Set.new(where(:closet_id => closet_id))
    buyer_reviews.intersection(closet_reviews).to_a
  end
end

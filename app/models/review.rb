class Review < ActiveRecord::Base
  attr_accessible :content

  belongs_to :closet
  belongs_to :user

  def self.made_by(user)
    where(:user_id => user.id)
  end
end

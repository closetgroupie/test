class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :target, :class_name => "User"

  attr_accessible :user_id, :target_id
end

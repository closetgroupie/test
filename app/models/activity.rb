class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :action, polymorphic: true
  belongs_to :entity, polymorphic: true

  attr_accessible :user, :action, :entity

  paginates_per 40

  # Exclude follows from the listing
  default_scope where("NOT action_type = 'Relationship'").order("created_at DESC")

  def self.since(timestamp)
    where("updated_at > ?", Time.at(timestamp+1).utc)
  end

  def self.before(timestamp)
    where("updated_at < ?", Time.at(timestamp).utc)
  end

  def self.since_id(since_id)
    where("id < ?", since_id).limit(20)
  end

  def classification
    case action_type
    when "Item" then "added"
    when "Favorite" then "favorited"
    when "Relationship" then "followed"
    when "Order" then "purchased"
    when "Cart" then "purchased"
    else
      "undefined"
    end
  end

  def is_purchase?
    if action_type == "Cart" or action_type == "Order"
      true
    else
      false
    end
  end
end

class Activity < ActiveRecord::Base
  belongs_to :user
  belongs_to :action, polymorphic: true
  belongs_to :entity, polymorphic: true

  attr_accessible :user, :action, :entity

  # Exclude follows from the listing
  default_scope where("NOT action_type = 'Relationship'")

  def self.latest
    order("created_at DESC").limit(40)
  end

  def self.since(since_id)
    where("id < ?", since_id).order("created_at DESC").limit(20)
  end
end

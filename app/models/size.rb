class Size < ActiveRecord::Base
  attr_accessible :name, :ordering, :size_group_id

  belongs_to :size_group

  def self.default_scope
    order("size_group_id, ordering")
  end

  def to_s
    name
  end
end

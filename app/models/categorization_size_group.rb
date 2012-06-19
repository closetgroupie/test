class CategorizationSizeGroup < ActiveRecord::Base
  belongs_to :segment
  belongs_to :category
  belongs_to :size_group

  attr_accessible :segment_id, :category_id, :size_group_id, :ordering
end

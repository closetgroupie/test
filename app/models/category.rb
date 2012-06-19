class Category < ActiveRecord::Base
  belongs_to :segment

  has_many :items

  has_many :categorization_size_groups
  has_many :size_groups, through: :categorization_size_groups
  has_many :sizes, through: :size_groups

  attr_accessible :name, :slug, :ordering, :parent_id
end

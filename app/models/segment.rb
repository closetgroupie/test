class Segment < ActiveRecord::Base
  has_many :brands
  has_many :categories
  has_many :items

  attr_accessible :name, :slug
end

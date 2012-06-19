class SizeGroup < ActiveRecord::Base
  attr_accessible :name

  has_many :sizes
end

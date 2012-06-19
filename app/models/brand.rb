class Brand < ActiveRecord::Base
  attr_accessible :name, :slug

  belongs_to :segment

  def to_s
    name
  end
end

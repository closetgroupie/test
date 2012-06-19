class Photo < ActiveRecord::Base
  belongs_to :item
  attr_accessible :image, :item_id, :ordering

  mount_uploader :image, ImageUploader
end

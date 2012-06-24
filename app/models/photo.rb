class Photo < ActiveRecord::Base
  belongs_to :item
  attr_accessible :image, :item_id, :ordering

  mount_uploader :image, ImageUploader

  def rotate!(degrees)
    image.manipulate! do |photo|
      photo.rotate degrees.to_s
      photo = yield(photo) if block_given?
      photo
    end
    save!
    image.recreate_versions!
  end
end

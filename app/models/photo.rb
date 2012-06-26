class Photo < ActiveRecord::Base
  belongs_to :item
  attr_accessible :image, :item_id, :ordering, :original_name
  before_create :record_original_name

  default_scope order("ordering DESC, id ASC")

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

  private
  def record_original_name
    self.original_name = image_identifier
  end

end

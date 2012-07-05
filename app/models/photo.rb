class Photo < ActiveRecord::Base
  belongs_to :item
  attr_accessible :image, :item_id, :ordering, :original_name, :filename_seed
  before_create :record_original_name

  default_scope order("photos.ordering DESC, photos.id ASC")

  mount_uploader :image, ImageUploader

  def rotate!(degrees)
    generate_filename_seed!
    image.manipulate! do |photo|
      photo.rotate degrees.to_s
      photo = yield(photo) if block_given?
      photo
    end
    save!
    image.recreate_versions!
  end

  def generate_filename_seed!
    update_attribute('filename_seed', Digest::MD5.hexdigest(Time.now.usec.to_s))
  end

  private
  def record_original_name
    self.original_name = image_identifier
  end

end

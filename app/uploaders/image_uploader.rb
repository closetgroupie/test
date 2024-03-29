# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def legacy_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.item.legacy_id}"
  end

  def tmp_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/tmp/#{model.item.legacy_id}"
  end

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.item_id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end
  # TODO: Should this be created from one of the larger images?
  version :search do
    process resize_to_fill: [190, 190]
  end

  version :medium do
    process resize_to_fill: [200, 200]
  end

  version :thumbnail do
    process resize_to_fill: [80, 80]
  end

  version :hero do
    process resize_to_limit: [345, nil]
  end

  version :activity do
    process resize_to_fit: [176, nil]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    if original_filename
      "#{filename_seed}.#{file.extension}"
    end
  end

  protected
  def filename_seed
    model.generate_filename_seed! unless model.filename_seed
    model.filename_seed
  end
end

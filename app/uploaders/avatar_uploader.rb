# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base

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
  def store_dir
    # "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    # For Rails 3.1+ asset pipeline compatibility:
    asset_path("fallback/" + [version_name, "default.jpg"].compact.join('_'))
    # "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  #
  # Used for shop by closet page
  version :large do
    # 300x300? or 250x250?
    process resize_to_fill: [250, 250]
  end

  # Used for search results
  version :search, from_version: :large do
    process resize_to_fill: [190, 190]
  end

  # Used for fancy profile pic and on the settings sidebar
  version :medium, from_version: :search do
    process resize_to_fill: [170, 170]
  end

  version :preview, from_version: :medium do
    process resize_to_fill: [80, 80]
  end

  # Used just about everywhere where we're showing a small image of the user
  version :thumb, from_version: :medium do
    process resize_to_fill: [60, 60]
  end

  # Used for facebook comments in the feed
  version :mini, from_version: :thumb do
    process resize_to_fill: [30, 30]
  end


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end

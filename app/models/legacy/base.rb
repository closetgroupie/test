#require 'acts_as_importable'
require 'date'

class Legacy::Base < ActiveRecord::Base
  self.abstract_class = true
  establish_connection "legacy"

#  acts_as_importable

  def convert_to_datetime(timestamp_field)
    DateTime.strptime(timestamp_field.to_s, "%s")
  end
end

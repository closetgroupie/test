class CuratorApplication < ActiveRecord::Base
  TEXT_FIELD_ATTRS = [:first_name, :last_name, :email, :phone, :primary, :secondary, :city, :state, :zip]
  # TODO: This should be moved in to something like copycopter or such for easier editing
  PLACEHOLDER_TEXTS = {
    :primary => "Street address",
    :secondary => "Suite, Apt, etc."
  }

  belongs_to :user

  attr_accessible :about, :user_id, *TEXT_FIELD_ATTRS

  validates :about, *TEXT_FIELD_ATTRS.reject { |key| key == :secondary }, :presence => true

  def full_name
    "#{first_name} #{last_name}"
  end

  def text_fields
    TEXT_FIELD_ATTRS
  end

  def placeholder_text(key)
    PLACEHOLDER_TEXTS.fetch(key, key.to_s.humanize)
  end
end

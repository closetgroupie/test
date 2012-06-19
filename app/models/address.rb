class Address < ActiveRecord::Base
  attr_accessible :recipient,
                  :primary,
                  :secondary,
                  :city,
                  :state,
                  :zip,
                  :country

  has_many :purchase, :through => :purchase_shipping_address
end

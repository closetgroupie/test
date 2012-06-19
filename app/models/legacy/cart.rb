class Legacy::Cart < Legacy::Base
  set_table_name 'orders'

  def to_model
    user = ::User.find_by_legacy_id(self.user_id)
    address = ::Address.where({
      :recipient => self.shipping_name,
      :primary => self.shipping_address,
      :secondary => self.shipping_address2,
      :city => self.shipping_city,
      :state => self.shipping_state,
      :zip => self.shipping_zip,
      :user_id => user.id
    }).first

    if user.present? and address.present?
      ::Cart.new do |c|
        c.legacy_id = self.id
        c.legacy_uid = self.unique_id
        c.user_id = user.id
        c.purchased_at = self.completed_on.zero? ? nil : convert_to_datetime(self.completed_on)
        c.created_at = convert_to_datetime(self.created)
        c.updated_at = cart_updated_at
        c.shipping_address_id = address.id
      end
    end
  end

  private

    def cart_updated_at
      if self.completed_on.zero?
        convert_to_datetime(self.created)
      else
        convert_to_datetime(self.completed_on)
      end
    end
end

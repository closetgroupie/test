class Legacy::Order < Legacy::Base
  set_table_name 'sub_orders'

  def to_model
    cart = ::Cart.find_by_legacy_id(self.order_id)
    buyer = ::User.find_by_legacy_id(self.buyer)
    seller = ::User.find_by_legacy_id(self.seller)

    if cart.present?
      ::Order.new do |o|
        o.legacy_id = self.id
        o.legacy_uid = self.unique_id
        o.cart_id = cart.id
        o.created_at = convert_to_datetime(self.created)
        o.updated_at = order_updated_at
        o.buyer_id   = buyer.id
        o.seller_id  = seller.id
        o.purchased_at = self.completed_on.zero? ? nil : convert_to_datetime(self.completed_on)
      end
    end
  end

  private

    def order_updated_at
      if self.completed_on.zero?
        convert_to_datetime(self.created)
      else
        convert_to_datetime(self.completed_on)
      end
    end
end

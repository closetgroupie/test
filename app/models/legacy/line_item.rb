class Legacy::LineItem < Legacy::Base
  set_table_name 'order_items'

  def to_model
    cart  = ::Cart.find_by_legacy_id(self.order_id)
    order = ::Order.find_by_legacy_id(self.sub_order_id)
    item  = ::Item.find_by_legacy_id(self.item_id)

    if cart.present? and order.present? and item.present?
      ::LineItem.new do |li|
        li.legacy_id = self.id
        li.cart_id = cart.id
        li.order_id = order.id
        li.item_id = item.id
        li.price = self.price
        li.created_at = convert_to_datetime(self.created)
        li.updated_at = convert_to_datetime(self.created)
      end
    else
      puts cart
      puts order
      puts item
    end
  end
end

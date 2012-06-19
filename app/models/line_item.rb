class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item
  belongs_to :order

  delegate :shipping_cost, to: :item

  attr_accessible :cart_id, :item_id, :order_id, :price
end

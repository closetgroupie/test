class OrderPresenter < BasePresenter
  presents :order
  delegate :buyer, :buyer_id, :closetgroupie_fee, :id, :items, :unique_id,
           :total, :total_earned, to: :order

  def shipping
    @shipping ||= order.cart.shipping_address
  end

  def item_count
    @item_count ||= order.items.size
  end
end

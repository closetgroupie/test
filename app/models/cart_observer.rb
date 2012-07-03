class CartObserver < ActiveRecord::Observer
  def after_update(cart)
    if cart.purchased_at_changed? and cart.purchased_at_was.nil?
      PurchaseMailer.delay.purchase_made_email(cart.id)
      cart.items.each do |item|
        FacebookWorker.perform_async('item_bought', {'user' => cart.user.id, 'item' => item.id})
      end
    end
  end
end

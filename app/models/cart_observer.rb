class CartObserver < ActiveRecord::Observer
  def after_update(cart)
    if cart.purchased_at_changed? and cart.purchased_at_was.nil?
      PurchaseMailer.delay.purchase_made_email(cart.id)
      FacebookWorker.perform_async('item_bought', {'user' => model.user.id, 'item' => model.id})
    end
  end
end

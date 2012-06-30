class CartObserver < ActiveRecord::Observer
  def after_update(cart)
    if cart.purchased_at_changed? # TODO: and cart.purchased_at_was.nil?
      PurchaseMailer.delay.purchase_made_email(cart.id)
    end
  end
end

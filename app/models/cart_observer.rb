class CartObserver < ActiveRecord::Observer
  def after_update(cart)
    if cart.purchased_at_changed?
      PurchaseMailer.purchase_made_email(cart).deliver
    end
  end
end

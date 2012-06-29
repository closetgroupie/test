class PurchaseMailer < ActionMailer::Base
  helper :application

  default from: "ClosetGroupie.com <no-reply@closetgroupie.com>"
  layout "email"

  def purchase_made_email(cart)
    @cart = cart
    @buyer = User.find(cart.user_id)
    @orders = cart.orders
    mail(to: @buyer.email, subject: "Thanks for your purchase from ClosetGroupie!")
  end
end

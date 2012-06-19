class OrderMailer < ActionMailer::Base
  helper :application
  # TODO: This should be something more fun than just no-reply...
  # default from: "no-reply@closetgroupie.com"
  default from: "ClosetGroupie.com <no-reply@closetgroupie.com>"
  # TODO: Better naming
  layout "email"
  
  def sale_made_email(order)
    @seller = User.find(order.seller_id)
    @order  = order
    mail(to: @seller.email, subject: "You've made a sale on ClosetGroupie")
  end

  def purchase_made_email(cart)
  end
end

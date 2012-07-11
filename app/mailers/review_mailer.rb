class ReviewMailer < ActionMailer::Base
  helper :application

  default from: "ClosetGroupie.com <no-reply@closetgroupie.com>"
  layout "email"

  def review_reminder_email(buyer_id, closet_id)
    @buyer = User.find(buyer_id)
    @seller = Closet.find(closet_id).user
    @orders = Order.where(:buyer_id => buyer_id, :seller_id => @seller.id)
    mail(to: @buyer.email, subject: "Leave feedback for #{@seller.name} on ClosetGroupie")
  end
end

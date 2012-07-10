# responsible for checking to see if a
# user has left a review following an order and then
# queuing a reminder e-mail
class ReminderDeliveryWorker
  include Sidekiq::Worker

  def perform(order_id)
    o = Order.find(order_id)
    seller = User.find(o.seller_id)
    if Review.made_by_buyer_for_closet(o.buyer_id, seller.closet_id).count == 0
      ReviewMailer.delay.review_reminder_email(o.seller_id, o.buyer_id)
    end
  end
end

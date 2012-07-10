# responsible for checking to see if a
# user has left a review following an order and then
# queuing a reminder e-mail
class ReminderDeliveryWorker
  include Sidekiq::Worker

  def perform(order_id)
    o = Order.find(order_id)
    closet_id = Order.items.last.closet_id
    if Review.made_by_buyer_for_closet(o.buyer_id, closet_id).count == 0
      ReviewMailer.review_reminder_email(closet_id, o.buyer_id).deliver
    end
  end
end

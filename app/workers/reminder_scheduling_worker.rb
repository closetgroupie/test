# responsible for scheduling a review checkup
# seven days following an order
class ReminderSchedulingWorker
  include Sidekiq::Worker

  def perform(order_id)
    ReminderDeliveryWorker.perform_in(7.days, order_id)
  end

end

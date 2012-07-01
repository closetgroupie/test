class MessageObserver < ActiveRecord::Observer
  def after_create(model)
    MessageMailer.delay.new_message_email(model.id)
  end
end

class MessageObserver < ActiveRecord::Observer
  def after_create(model)
    MessageMailer.new_message_email(model.id).deliver
  end
end

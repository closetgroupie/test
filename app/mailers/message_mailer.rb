class MessageMailer < ActionMailer::Base
  default from: "ClosetGroupie.com <no-reply@closetgroupie.com>"
  layout "email"

  def new_message_email(message_id)
    @message = Message.includes(:sender, :recipient).find(message_id)
    @sender  = @message.sender
    mail(to: @message.recipient.email,
         subject: "You have received a new message from #{@sender.name} on ClosetGroupie")
  end

end

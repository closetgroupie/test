class MessageMailer < ActionMailer::Base
  default from: "ClosetGroupie.com <no-reply@closetgroupie.com>"
  layout "email"

  def new_message_email(message)
    @message = message
    mail(to: message.recipient.email,
         subject: "You have received a new message from #{message.sender.name} on ClosetGroupie")
  end
end

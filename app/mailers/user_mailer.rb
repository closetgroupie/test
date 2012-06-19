class UserMailer < ActionMailer::Base
  # TODO: This should be something more fun than just no-reply...
  default from: "ClosetGroupie.com <no-reply@closetgroupie.com>"
  # TODO: Better naming
  layout "email"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reset_password_email.subject
  #
  def reset_password_email(user)
    @user = user
    @url  = edit_forgot_password_url(user.reset_password_token)
    mail(to: user.email,
         subject: "Your ClosetGroupie password has been reset")
  end

  def new_follower_email(relationship_id)
    relationship = Relationship.includes(:user, :target).find(relationship_id)
    @follower = relationship.user
    mail(to: relationship.target.email,
         subject: "#{@follower.name} is now following your closet")
  end
end

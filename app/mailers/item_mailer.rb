class ItemMailer < ActionMailer::Base
  helper :application

  default from: "ClosetGroupie.com <no-reply@closetgroupie.com>"
  layout "email"

  def item_of_interest_email(item, groupie)
    @item, @groupie = item, groupie
    mail(to: groupie.email,
         subject: "#{@item.user.name} listed #{@item.title} on ClosetGroupie!")
  end
end

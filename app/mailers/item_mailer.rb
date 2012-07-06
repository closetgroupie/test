class ItemMailer < ActionMailer::Base
  helper :application

  default from: "ClosetGroupie.com <no-reply@closetgroupie.com>"
  layout "email"

  def item_of_interest_email(item_id, groupie_id)
    @item = Item.find(item_id)
    @groupie = User.find(groupie_id)
    mail(to: @groupie.email,
         subject: "#{@item.user.name} listed #{@item.title} on ClosetGroupie!")
  end

end

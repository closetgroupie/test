class ItemMailer < ActionMailer::Base
  helper :application

  default from: "ClosetGroupie.com <no-reply@closetgroupie.com>"
  layout "email"

  def item_of_interest_email(item, groupie)
    @item, @groupie = item, groupie
    mail(to: groupie.email,
         subject: "#{@item.user.name} listed #{@item.title} on ClosetGroupie!")
  end

  def new_item_email(item_id, groupie_id)
    @groupie = User.find(groupie_id)
    @item    = Item.includes(:user).find(item_id)
    @user    = @item.user
    mail(to: @groupie.email,
         subject: "#{@user.name} posted a new item on ClosetGroupie")
  end
end

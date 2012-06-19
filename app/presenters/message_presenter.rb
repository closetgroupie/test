class MessagePresenter < BasePresenter
  presents :message
  delegate :content, to: :message

  def day
    message.created_at.day
  end

  def month
    message.created_at.to_s(:short_month)
  end

  def year
    message.created_at.year
  end

  def author
    message.sender.name
  end

  def author_avatar
    h.image_tag message.sender.avatar_url(:thumb),
      alt: message.sender.name,
      width: 60,
      height: 60
  end

  def status_for(user)
    "new" if message.unread? and message.recipient_id == user.id
  end
end

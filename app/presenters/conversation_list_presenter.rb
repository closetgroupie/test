class ConversationListPresenter < BasePresenter
  presents :conversation

  def day
    conversation.created_at.day
  end

  def month
    conversation.created_at.to_s(:short_month)
  end

  def year
    conversation.created_at.year
  end

  def has_unread_messages?
    conversation.messages.any? { |m| m.unread? and m.recipient_id == h.current_user.id }
  end

  def hero_image
    # TODO: Rename?
    h.content_tag(:div, :class => "hero-img") do
      h.image_tag image_for_object, :class => "img-shadow", width: 60, height: 60
    end
  end

  def latest_message
    h.content_tag :p, latest.content, :class => "message-content"
  end

  def latest_from
    h.content_tag :h5, latest.sender.name
  end

  def linked_message_count
    h.link_to h.pluralize(conversation.messages.size, "message"),
      h.conversation_path(conversation)
  end

  def user_avatar
    h.image_tag other_party.avatar_url(:thumb), :class => "img-shadow",
      :alt => other_party.name
  end

  private

    def image_for_object
      path = case conversation.conversable_type
              when "Item"
                # TODO: clean this up, implement a preview/thumb in the photos
                conversation.conversable.photos.first.image_url
              when "Order"
                h.image_path "order-message-icon.jpg"
             end
    end

    def latest
      conversation.messages.first
    end
  
    def other_party
      @other ||= (conversation.recipient == h.current_user) ? conversation.sender : conversation.recipient
    end
end

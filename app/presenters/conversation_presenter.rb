class ConversationPresenter < BasePresenter
  presents :conversation

  def subject_image
    h.image_tag image_for_object, :class => "img-shadow", width: 60, height: 60
  end

  def sender
    case conversation.conversable_type.downcase
    when "item"
      # TODO: Is this even necessary?
      conversation.conversable.user.name
    when "order"
      if buyer_to_seller
        conversation.conversable.seller.name
      else
        conversation.conversable.buyer.name
      end
    else
      ""
    end
  end

  def subject
    h.content_tag :h4 do
      "Regarding the #{subject_type} #{subject_link}".html_safe
    end
  end

  def subject_name
    case conversation.conversable_type.downcase
    when "item"
      conversation.conversable.title
    when "order"
      buyer_to_seller ? conversation.conversable.cart.unique_id : conversation.conversable.unique_id
    else
      ""
    end
  end

  def submit_path(object)
    case conversation.conversable_type
    when "Item"
      h.question_item_path(object)
    when "Order"
      if buyer_to_seller
        h.contact_seller_path(object)
      else
        h.contact_buyer_path(object)
      end
    end
  end

  def messages
    conversation.messages.collect { |m| MessagePresenter.new(m, @template, {}) }
  end

  private
    def buyer_to_seller
      @buyer_to_seller ||= conversation.conversable.buyer == h.current_user
    end

    def image_for_object
      path = case conversation.conversable_type
              when "Item"
                # TODO: clean this up, implement a preview/thumb in the photos
                conversation.conversable.photos.first.image_url
              when "Order"
                h.image_path "order-message-icon.jpg"
             end
    end

    def subject_link
      h.link_to subject_properties[:name], subject_properties[:path]
    end

    def subject_properties
      properties = case conversation.conversable_type
      when "Item"
        {
          :name => conversation.conversable.title,
          :path => h.item_path(conversation.conversable)
        }
      when "Order"
        {
          # TODO: Properties for orders
          :name => subject_name,
          :path => buyer_to_seller ? h.purchase_path(conversation.conversable.cart_id) : h.sale_path(conversation.conversable)
        }
      end
    end

    def subject_type
      conversation.conversable_type.downcase
    end
end

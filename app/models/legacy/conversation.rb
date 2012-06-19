class Legacy::Conversation < Legacy::Base
  set_table_name 'message_threads'

  # belongs_to :user,
  #            :class_name => "Legacy::User",
  #            :foreign_key => "created_by"

  # belongs_to :user,
  #            :class_name => "Legacy::User",
  #            :foreign_key => "addressed_to"

  def to_model
    sender = ::User.find_by_legacy_id(self.created_by)
    recipient = ::User.find_by_legacy_id(self.addressed_to)
    conversable = resolve_conversable

    if sender.present? and recipient.present? and conversable.present?
      ::Conversation.new do |c|
        c.legacy_id = self.id
        c.sender_id = sender.id
        c.recipient_id = recipient.id
        c.conversable_type = conversable.class.name
        c.conversable_id = conversable.id
        c.created_at = convert_to_datetime(self.created)
        c.updated_at = convert_to_datetime(self.updated)
      end
    end
  end

  private

  def resolve_conversable
    if not self.item_id.zero?
      ::Item.find_by_legacy_id(self.item_id)
    else
      ::Order.find_by_legacy_id(self.sub_order_id)
    end
  end
end

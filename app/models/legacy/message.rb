class Legacy::Message < Legacy::Base
  set_table_name 'messages'

  def to_model
    conversation = ::Conversation.find_by_legacy_id(self.message_thread_id)
    sender = ::User.find_by_legacy_id(self.user_id)
    recipient = ::User.find_by_legacy_id(self.addressed_to)

    if conversation.present? and sender.present? and recipient.present?
      ::Message.new do |m|
        m.conversation_id = conversation.id
        m.sender_id = sender.id
        m.recipient_id = recipient.id
        m.content = self.content
        m.created_at = convert_to_datetime(self.created)
        m.updated_at = convert_to_datetime(self.created)
        m.unread = false
      end
    end
  end
end

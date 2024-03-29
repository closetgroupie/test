class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  attr_accessible :content, :sender_id, :recipient_id

  validates :content, :sender_id, presence: true

  def self.unread_count_for(user)
    where(:recipient_id => user, :unread => true)
  end
end

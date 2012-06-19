class Conversation < ActiveRecord::Base
  belongs_to :conversable, polymorphic: true
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"

  has_many :messages, :order => "created_at desc", :dependent => :destroy

  validates :sender_id, :recipient_id, presence: true

  attr_accessible :sender_id, :recipient_id

  def reply_from(params, user)
    message = messages.build({
      sender_id: user,
      content: params[:content]
    })

    if new_record?
      save
    else
      message.save
    end
  end

  def self.for_user(user)
    where("recipient_id = ? OR sender_id = ?", user.id, user.id)
  end

  def self.with_properties(options)
    
  end
end

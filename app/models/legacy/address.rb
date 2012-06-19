class Legacy::Address < Legacy::Base
  set_table_name 'user_addresses'
  # set_primary_key 'id'
  
  belongs_to :user,
             :class_name  => "Legacy::User",
             :foreign_key => "user_id"

  def to_model
    new_user = User.find_by_legacy_id(self.user_id)
    ::Address.new do |a|
      a.user_id   = new_user.id
      a.recipient = self.full_name
      a.primary   = self.street1
      a.secondary = self.street2
      a.city      = self.city
      a.state     = self.state_region
      a.zip       = self.postal_code
      a.country   = "US"
    end unless new_user.nil?
  end
end

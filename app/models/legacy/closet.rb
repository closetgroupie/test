class Legacy::Closet < Legacy::Base
  set_table_name 'closets'

  belongs_to :user,
             :class_name => 'Legacy::User',
             :foreign_key => 'user_id'

  def to_model
    new_user = User.find_by_legacy_id(self.user_id)
    ::Closet.new do |c|
      c.user_id  = new_user.id
      c.legacy_id = self.id
      c.name = self.name
      c.created_at = convert_to_datetime(self.created)
      c.updated_at = convert_to_datetime(self.created)
    end unless new_user.nil?
  end
end

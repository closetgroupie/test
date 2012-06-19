class Legacy::Relationship < Legacy::Base
  set_table_name 'follows'

  def to_model
    user = ::User.find_by_legacy_id(self.user_id)
    target = ::User.find_by_legacy_id(self.following)

    if user.present? and target.present?
      ::Relationship.new do |r|
        r.legacy_id = self.id
        r.user_id = user.id
        r.target_id = target.id
        r.created_at = convert_to_datetime(self.created)
        r.updated_at = convert_to_datetime(self.created)
      end
    end
  end
end

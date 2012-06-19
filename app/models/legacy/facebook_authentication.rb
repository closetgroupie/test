class Legacy::FacebookAuthentication < Legacy::Base
  set_table_name 'facebook_connections'

  def to_model
    user = ::User.find_by_legacy_id(self.user_id)

    if user.present?
      ::Authentication.new do |a|
        a.legacy_id = self.id
        a.provider = "facebook"
        a.user_id = user.id
        a.uid = self.facebook_id
        a.access_token = self.oauth_token
      end
    end
  end
end

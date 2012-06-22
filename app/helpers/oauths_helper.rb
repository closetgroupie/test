module OauthsHelper
  def persist_facebook_access_token(user, token)
    if user.facebook_authentication.access_token.nil? or not user.current_on_facebook?
      user.facebook_authentication.access_token = token
      user.facebook_authentication.save
    end
  end
end

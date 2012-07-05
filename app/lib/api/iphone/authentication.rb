module Api
  class Iphone
    class Authentication < Grape::API
      format :json

      helpers do
        include Helpers::Errors
        include Helpers::Login
      end

      before { @method = validate_authentication_attempt! }

      post \
        :authentications,
        :params => {
          :facebook => {
            :access_token => 'Facebook OAuth access token. Must be sent in conjuction with the `uid` param.',
            :uid          => 'Facebook user id. Must be sent in conjuction with the `access_token` param.'
          },
          :identity => {
            :email    => 'Users native ClosetGroupie account email address. Must be sent in conjunction with `password`.',
            :password => 'Users native ClosetGroupie account password. Must be sent in conjunction with `email`.'
          }
        } \
      do
        user = authenticate_for! @method
        present user , :with => Entities::User
      end
    end
  end
end

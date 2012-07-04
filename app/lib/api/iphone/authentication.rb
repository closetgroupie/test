module Api
  class Iphone
    class Authentication < Grape::API
      format :json

      helpers do
        def authenticate_facebook
          auth = ::Authentication
                   .includes( :user )
                   .where( :uid => params[ :uid ] , :provider => :facebook )
                   .first

          user = ( auth and auth.user )
          json_error!( "No user with that Facebook `uid`!" , 401 ) if user.blank?
          user
        end

        def authenticate_for!( method )
          case method
          when :facebook
            authenticate_facebook
          when :identity
            authenticate_identity
          else
            json_error! "Unkown error!"
          end
        end

        def authenticate_identity
          user = User.authenticate( params[ :email ] , params[ :password ] )
          json_error!( "Invalid `email` and `password` combination!" , 401 ) if user.blank?
          user
        end

        def json_error!( errors , code = 403 )
          error!( { :errors => [ errors ].flatten } , code )
        end

        def validate_authentication_attempt!
          case
          when valid_facebook_authentication_attempt?
            :facebook
          when valid_identity_authentication_attempt?
            :identity
          else
            json_error! "Invalid credentials!" , 401
          end
        end

        def valid_identity_authentication_attempt?
          route.route_params[ :identity ].keys.all? do | identity_key |
            !params[ identity_key ].blank?
          end
        end

        def valid_facebook_authentication_attempt?
          route.route_params[ :facebook ].keys.all? do | identity_key |
            !params[ identity_key ].blank?
          end
        end
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
        present user , :with => Api::Entities::User
      end
    end
  end
end

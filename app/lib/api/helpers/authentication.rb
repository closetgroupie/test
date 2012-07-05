module Api
  module Helpers
    module Authentication
      # Authorization: CGX my-api-key
      def api_key
        parts = raw_api_key.split ' '
        json_error!( 'Invalid `Authorization` scheme!' , 401 ) unless parts[ 0 ] == 'CGX'
        parts[ 1 ]
      end

      def authenticate!
        return @current_user if @current_user

        @current_user = ::User
                          .where( :api_key => api_key )
                          .first

        json_error!( 'No user for that `api_key`!' , 401 ) unless @current_user
      end

      def raw_api_key
        env[ 'HTTP_AUTHORIZATION' ]
      end
    end
  end
end

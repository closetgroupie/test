module Api
  module Helpers
    module Errors
      def json_error!( errors , code = 403 )
        error!( { :errors => [ errors ].flatten } , code )
      end
    end
  end
end

module Api
  module Entities
    class User < Grape::Entity
      expose :name
      expose :email
      expose :id

      expose :avatar_url do | user , options |
        "http://localhost:3000#{ user.avatar_url }"
      end

      expose( :api_key ){ "abc123" }
    end
  end
end

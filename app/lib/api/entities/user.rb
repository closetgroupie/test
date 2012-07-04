module Api
  module Entities
    class User < Grape::Entity
      expose :name
      expose :email
      expose :id

      expose :avatar_url do | user , options |
        "https://closetgroupie.com#{ user.avatar_url }"
      end

      expose( :api_key ){ "abc123" }
    end
  end
end

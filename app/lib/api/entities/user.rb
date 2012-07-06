module Api
  module Entities
    class User < Grape::Entity
      expose :name
      expose :email
      expose :id
      expose :avatar_url do | user , options |
        base = Closetgroupie::Application.config.base_url
        "#{base}#{user.avatar_url}"
      end
      expose :api_key
    end
  end
end

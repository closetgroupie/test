module Api
  module Entities
    class User < Grape::Entity
      expose :name
      expose :email
      expose :id
      expose :avatar_url do | user , options |
        # TODO: Come up with a better implementation.
        base = Rails.env.production? ? 'https://closetgroupie.com' : 'http://localhost:3000'
        "#{base}#{user.avatar_url}"
      end
      expose :api_key
    end
  end
end

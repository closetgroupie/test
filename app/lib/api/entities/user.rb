module Api
  module Entities
    class User < Grape::Entity
      expose :name
      expose :email
      expose :id
      expose :avatar_url
      expose( :api_key ){ "abc123" }
    end
  end
end

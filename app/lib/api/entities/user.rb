module Api
  module Entities
    class User < Grape::Entity
      expose :name
      expose :email
      expose :id
      expose :avatar_url do | user , options |
        # TODO: If we ever remove the asset_path from app/uploaders/avatar_uploader.rb default
        # url, we need to remove this check and simply use the Closetgroupie::App base_url
        base = user.avatar.blank? ? '' : Closetgroupie::Application.config.base_url
        "#{base}#{user.avatar_url}"
      end
      expose :api_key
    end
  end
end

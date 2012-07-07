require 'net/http'
require 'uri'

class FacebookAvatarWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.includes(:facebook_authentication).find(user_id)
    if user.present? and user.facebook_authentication.present?
      avatar_url = fetch(facebook_avatar_url(user))
      if File.fnmatch('.jpg', File.extname(avatar_url))
        user.remote_avatar_url = avatar_url
        user.save!
      end
    end
  end

  private

  def facebook_avatar_url(user)
    "https://graph.facebook.com/#{user.facebook_authentication.uid}/picture?type=large"
  end

  # Convenience method for fetching the avatar url
  def fetch(uri_str, limit = 10)
    # You should choose better exception.
    raise ArgumentError, 'HTTP redirect too deep' if limit == 0

    url = URI.parse(uri_str)
    path_query = url.query.nil? ? url.path : "#{url.path}?#{url.query}"

    request = Net::HTTP::Get.new(path_query)
    response = Net::HTTP.start(url.host) { |http| http.request(request) }

    case response
      when Net::HTTPSuccess     then response
      when Net::HTTPRedirection then response['location']
      else
        response.error!
      end
  end
end

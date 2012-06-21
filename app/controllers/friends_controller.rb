class FriendsController < ApplicationController
  include FriendsHelper

  def index
    if current_user.has_facebook?
      #@friends = get_friends_for_current_user
      cache_current_user_friends
      cache_facebook_members
      #cache_facebook_profile(current_user.facebook_authentication.uid)
      #binding.pry
    end
  end

end

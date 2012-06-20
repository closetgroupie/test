class FriendsController < ApplicationController
  include FriendsHelper

  def index
    if current_user.has_facebook?
      @friends = get_friends_for_current_user
    end
  end

end

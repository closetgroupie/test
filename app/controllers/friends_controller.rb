class FriendsController < ApplicationController
  include FriendsHelper

  before_filter :require_login

  def index
    if current_user and current_user.has_facebook?
      @friends = get_friends_using_site(current_user.facebook_authentication.uid)
    end
  end

end

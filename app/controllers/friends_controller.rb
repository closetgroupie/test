class FriendsController < ApplicationController
  include FriendsHelper

  def index
    if current_user.has_facebook?

      #3. Expose those to view.
      @friends = get_friends_using_site(current_user.facebook_authentication.uid)

    end
  end

end

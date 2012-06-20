module FriendsHelper
  def get_graph
    token = current_user.facebook_authentication.access_token
    @graph ||= Koala::Facebook::API.new token
  end

  def get_friends_for_current_user
    get_graph.get_connections(current_user.facebook_authentication.uid, "friends", :fields=>"name,picture")
  end

end

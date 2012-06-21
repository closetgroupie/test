module FriendsHelper
  def get_graph
    token = current_user.facebook_authentication.access_token
    @graph ||= Koala::Facebook::API.new token
  end

  def get_friends_for_current_user
    get_graph.get_connections(current_user.facebook_authentication.uid, "friends", :fields=>"name,picture")
  end

  def cache_current_user_friends
    friends = get_friends_for_current_user
    friend_ids = Array.new
    friends.each do |friend|
      friend_ids += [friend['id']]
    end
    cache_facebook_profiles(friend_ids)

    friends.each do |friend|
      REDIS.sadd("user:facebook_friends:user_#{current_user.facebook_authentication.uid}", friend['id'])
    end
  end

  def cache_facebook_members
    facebook_users = Authentication.where "provider = 'facebook'"

    member_facebook_ids = Array.new

    facebook_users.each do |user|
      REDIS.sadd("user:facebook_users", user.uid)
      member_facebook_ids += [user.uid]
    end

    cache_facebook_profiles(member_facebook_ids)
  end

  def cache_facebook_profiles(uids)
    profiles = get_graph.get_objects(uids, :fields=>"name,picture")
    #binding.pry
    profiles.each do |uid, profile|
      REDIS.set("user:facebook_users:user_#{uid}:name", profile['name'])
      REDIS.set("user:facebook_users:user_#{uid}:picture", profile['picture'])
    end
  end

end

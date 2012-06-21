require 'set'

# REDIS structure is:
#
# fb:<facebook_uid>:id
# fb:<facebook_uid>:friends
# fb:users

module FriendsHelper

  # Gets access to the Facebook Graph API with the current user's
  # authentication token
  def get_graph
    token = current_user.facebook_authentication.access_token
    @graph ||= Koala::Facebook::API.new token
  end

  def get_friends_using_site(fb_id)
    #1. Get all facebook friends
    recache_friends_if_needed(fb_id)

    #2. Recache site's users if needed
    recache_users_if_needed

    #3. Compare to list of current existing members.
    overlap = REDIS.sinter("fb:#{fb_id}:friends", "fb:users")

    #4. Return a list of users on the site
    users = Array.new
    overlap.each do |fb_id|
      site_id = REDIS.get("fb:#{fb_id}:uid")
      users.push(User.find site_id)
    end
   
    users
  end

  # Gets friends from the cache if applicable, otherwise
  # goes to facebook
  def recache_friends_if_needed(fb_id)
    # If cache has expired, hit Facebook and recache
    if 0 > REDIS.ttl("fb:#{fb_id}:friends")
      friends = get_graph.get_connections(fb_id, "friends", :fields=>"name,picture")
      friend_ids = Array.new
      friends.each do |friend|
        friend_ids += [friend['id']]
      end
      cache_facebook_profiles(friend_ids)

      friend_ids.each do |friend_id|
        REDIS.sadd("fb:#{fb_id}:friends", "#{friend_id}")
      end

      REDIS.expire("fb:#{fb_id}:friends", 30.days.to_i)
    end
  end

  def recache_users_if_needed
    if 0 > REDIS.ttl("fb:users")
      facebook_users = Authentication.where "provider = 'facebook'"

      member_facebook_ids = Array.new

      facebook_users.each do |user|
        REDIS.sadd("fb:users", user.uid)
        member_facebook_ids += [user.uid]
      end

      cache_facebook_profiles(member_facebook_ids)

      REDIS.expire("fb:users", 30.days.to_i)
    end
  end

  def cache_facebook_profiles(fb_uids)
    profiles = get_graph.get_objects(fb_uids, :fields => "name,picture")
    profiles.each do |fb_uid, profile|
      # We don't need these yet. Probably will for the invite system.
      #REDIS.set("fb:#{fb_uid}:name", profile['name'])
      #REDIS.expire("fb:#{fb_uid}:name", 30.days.to_i)
      #REDIS.set("fb:#{fb_uid}:picture", profile['picture'])
      #REDIS.expire("fb:#{fb_uid}:picture", 30.days.to_i)

      auth = Authentication.find_by_uid(fb_uid)
      if auth
        REDIS.set("fb:#{fb_uid}:uid", auth.user_id)
        REDIS.expire("fb:#{fb_uid}:uid", 30.days.to_i)
      end
    end
  end

end

object @activity
attributes :id, :updated_at

node(:classification) { |activity| activity.classification }

# TODO: Once we cache this, the favorites part needs to be moved elsewhere.
node(:is_favorite) { |activity| @favorites.include?(activity.entity_id) }

node(:entity_url) do |activity|
    case activity.entity_type
    when "Item" then item_path(activity.entity_id)
    when "User" then profile_path(activity.entity_id)
    end
end

node(:entity_name) do |activity|
    case activity.entity_type
    when "Item" then activity.entity.title
    when "User" then activity.entity.name
    end
end

node(:hero_image) do |activity|
    case activity.entity_type
    when "Item" then activity.entity.hero_image.image_url(:activity)
    when "User" then activity.entity.avatar_url(:search)
    end
end

node(:is_purchase) do |activity|
    activity.is_purchase?
end

node(:user_name) do |activity|
    if activity.is_purchase?
        "A member"
    else
        activity.user.name
    end
end

node(:user_profile_url) do |activity|
    if activity.is_purchase?
        ""
    else
        profile_path(activity.user)
    end
end

node(:verb) do |activity|
    case activity.action_type
    when "Item" then "added"
    when "Favorite" then "favorited"
    when "Relationship" then "followed"
    when "Order" then "purchased"
    when "Cart" then "purchased"
    else
      "Define action verb for #{activity.action_type}"
    end
end


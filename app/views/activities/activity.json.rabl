object @activity
attributes :id, :updated_at

node(:classification) { |activity| activity.classification }

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

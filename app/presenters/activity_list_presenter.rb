class ActivityListPresenter < BasePresenter
  presents :activity
  delegate :id, to: :activity

  def action_verb
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

  def can_be_favorited?
    activity.entity_type == "Item" ? true : false
  end

  def classification
    case activity.action_type
    when "Item" then "added"
    when "Favorite" then "favorited"
    when "Relationship" then "followed"
    when "Order" then "purchased"
    when "Cart" then "purchased"
    else
      "undefined"
    end
  end

  def comment_path
    @comment_path ||= entity_path + "#comments"
  end

  def comment_count
    # TODO: Implement
    0
  end

  def entity_id
    activity.entity.id
  end

  def favorite?
    activity.user.favorite?(activity.entity)
  end

  def has_comments?
    # TODO: Implement
    false
  end

  def linked_entity
    h.link_to entity_title, entity_path
  end

  def linked_hero_image
    h.link_to entity_path do
      h.image_tag entity_image, :class => "target"
    end
  end

  def linked_user
    if not activity.action_type == "Cart"
      h.link_to activity.user.name, h.profile_path(activity.user)
    else
      "A member"
    end
  end

  def time_ago
    h.content_tag :abbr, activity.created_at.to_date.to_s(:long),
      :class => "timeago",
      :title => activity.created_at.to_i
  end

  def to_partial_path
    "activities/activity"
  end

  private

    def entity_path
      case activity.entity_type
      when "Item" then h.item_path(activity.entity_id)
      when "User" then h.profile_path(activity.entity_id)
      end
    end

    def entity_image
      # TODO: Optimize & Reimplement 
      case activity.entity_type
      when "Item" then activity.entity.photos.first.image_url(:activity) if activity.entity.has_photos?
      when "User" then activity.entity.avatar_url(:search)
      end
    end

    def entity_title
      # TODO: Optimize
      case activity.entity_type
      when "Item" then activity.entity.title
      when "User" then activity.entity.name
      end
    end
end

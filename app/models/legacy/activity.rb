class Legacy::Activity < Legacy::Base
  set_table_name 'activities'

  MODEL_TO_ACTION = {
    "ItemImage" => "Photo",
    "Follow" => "Relationship",
    # "FacebookLike" => "FacebookLike",
    # "FacebookComment" => "FacebookComment",
    "FavoriteItem" => "Favorite",
    "Order" => "Cart",
    "OrderItem" => "LineItem"
  }

  def to_model
    user = ::User.find_by_legacy_id(self.user_id)
    action = resolve_action
    entity = resolve_entity(action)

    if user.present? and action.present? and entity.present?
      ::Activity.new do |a|
        a.legacy_id = self.id
        a.user_id = user.id
        a.action_id = action.id
        a.action_type = action.class.name
        a.entity_id = entity.id
        a.entity_type = entity.class.name
        a.created_at = convert_to_datetime(self.created)
        a.updated_at = convert_to_datetime(self.created)
      end
    end
  end

  private

    def resolve_action
      action_type = MODEL_TO_ACTION[self.model_alias]
      case action_type
      when "LineItem"
        temp = ::LineItem.includes(:cart).find_by_legacy_id(self.model_id)
        action = ::Cart.find(temp.cart_id) unless temp.nil?
      when "Photo"
        photo = ::Photo.find_by_legacy_id(self.model_id)
        action = ::Item.find(photo.item_id) unless photo.nil?
      when "Relationship"
        action = ::Relationship.find_by_legacy_id(self.model_id)
      when "Cart"
        action = ::Cart.find_by_legacy_id(self.model_id)
      when "Favorite"
        action = ::Favorite.find_by_legacy_id(self.model_id)
      # else
      #   kls = action_type.constantize
      #   action = ::kls.find_by_legacy_id(self.model_id) if kls.column_names.include? "legacy_id"
      end
      action
    end

    def resolve_entity(action_kls)
      unless action_kls.nil?
        if action_kls.class.name == "Relationship"
          entity = ::User.find_by_legacy_id(self.object_id)
        else
          entity = ::Item.find_by_legacy_id(self.object_id)
        end
        entity
      end
    end
end

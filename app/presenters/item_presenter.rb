class ItemPresenter < BasePresenter
  presents :item
  delegate :active_order, :closet, :closet_id, :line_item, :description, :description?, 
    :belongs_to_any_cart?, :id, :title, :user, :sold?, to: :item

  def brand
    item.brand.presence || item.brand_suggestion.presence || "N/A"
  end

  def condition
    conditions = Item::CONDITIONS.invert
    if conditions.include?(item.condition)
      conditions[item.condition]
    else
      "N/A"
    end
  end

  def delete_action
    h.content_tag :li do
      h.button_to("Delete", h.item_path(item), method: :delete,
        :class => "btn btn-img btn-delete-item-small", title: "Delete This Item",
        :confirm => "Are you sure you want to delete this item?")
    end if user_has_permissions?
  end

  def edit_action
    h.content_tag :li do
      h.link_to("Edit This Item", h.edit_item_path(item),
        :class => "btn btn-edit-item")
    end if user_has_permissions?
  end

  def hero_image
    if not item.photos.empty?
      # TODO: Take ordering/sorting in to account?
      item.photos.first.image_url(:hero)
    else
      # TODO: Default image?
    end
  end

  def owner
    user.name
  end

  def price
    price = h.number_to_currency(item.price)
    h.content_tag(:h2, "#{price} <em>USD</em>".html_safe) unless sold?
  end

  def shipping
    h.render("items/shipping", object: self) unless sold?
  end

  def shipping_abroad
    if item.shipping_abroad?
      "Yes"
    else
      "No"
    end
  end

  def show_buttons?
    not h.current_user == item.user
  end

  def size
    if item.size.present?
      item.size
    else
      "N/A"
    end
  end

  private
    
    def user_has_permissions?
      if h.current_user.present?
        h.current_user == user || h.current_user.admin?
      else
        false
      end
    end
end

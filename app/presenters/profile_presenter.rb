class ProfilePresenter < BasePresenter
  ITEM_SHOW_PATH = { controller: :items, action: :show }

  presents :user

  delegate :id, :avatar_url, :location, :number_of_groupies, :number_of_followings, to: :user

  def closet_name
    # TODO: Refactor
    if h.current_page?(ITEM_SHOW_PATH)
      h.content_tag :h3 do
        h.link_to closet.name, h.closet_path(closet)
      end
    else
      h.content_tag :h2 do
        h.link_to closet.name, h.closet_path(closet)
      end
    end
  end

  def closet
    user.closet
  end

  def location
    user.location.presence || "<span class='missing'>Not specified</span>".html_safe
  end

  def name
    # TODO: Refactor
    if h.current_page?(ITEM_SHOW_PATH)
      h.content_tag :h2, user.name 
    else
      h.content_tag :h1, user.name
    end
  end

  def profile_picture
    h.content_tag :div, :class => "polaroid" do
      h.image_tag user.avatar_url(:medium)
    end
  end

  # So the presenter can be rendered by itself
  def to_s
    h.render 'users/profile', user: self, user_model: @object
  end
  
  private

  def item_count
    user.items.size
  end

  def tag_for_page(text, condition, truthy, falsy)
    tag_name = h.current_page?(condition) ? truthy : falsy
    h.content_tag tag_name, text
  end
end

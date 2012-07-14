module ApplicationHelper
  def active_if_current(path)
    "active" if current_page?(path)
  end
  def body_class(class_string)
    # TODO: Add 'unregistered' to class_string if the current_user.nil?
    # body_class_string = if current_user.nil?
    #                       "#{class_string} unregistered"
    #                     else
    #                       class_string
    #                     end
    content_for(:body_class) { class_string }
  end

  def current_url
    url_for(:only_path => false)
  end

  def closet_preview_for(closet, user = nil, options = {})
    user ||= closet.user
    render :partial => "closets/preview", :locals => { :closet => closet, :user => user }
  end

  def filter_link(text, path, action_controller)
    klass = "active" if current_page?(action_controller)
    content_tag :li, link_to_unless_current(text, path), :class => klass
  end

  def present(object, klass = nil, options = {})
    if object.respond_to?(:each) # and object.any?
      klass ||= "#{object.first.class}Presenter".constantize
      wrapped = object.collect {|o| klass.new(o, self, options) }
    else
      klass ||= "#{object.class}Presenter".constantize
      wrapped = klass.new(object, self, options)
    end

    if block_given?
      yield wrapped
    else
      wrapped
    end
  end

  def messages_text
    if current_user
      if current_user.new_messages?
        content_tag :strong, pluralize(current_user.new_messages_count, "New Message")
      else
        "Your Messages"
      end
    else
      ""
    end
  end

  def profile_for(user, options = {})
    options.merge!({:params => params})
    presenter = present(user, ProfilePresenter, options)
  end

  def subnav_link_for(link_text, url, options = {})
    options[:class] = "active #{options[:class].to_s}" if request.path == url
    content_tag :li, options do
      link_to_unless_current link_text, url
    end
  end

  def toggle_favorite_button_for(item)
    # TODO: Refactor along with toggle_follow_button_for
    if current_user.present?
      if current_user.favorites.contain_item?(item)
        unfavorite_button_for(item)
      else
        favorite_button_for(item)
      end
    else
      link_to "Favorite", "#", title: "Please sign in or join now to favorite this item.",
        :class => "btn btn-inactive btn-favorite-placeholder btn-full btn-favorite-long"
    end
  end

  def toggle_follow_button_for(target, user = nil)
    # TODO: Refactor along with toggle_favorite_button_for
    user ||= current_user
    if user.present?
      if user.eql? target
        ""
      elsif user.followings.include?(target)
        unfollow_button_for(target)
      else
        follow_button_for(target)
      end
    else
      link_to "Follow", "#", :class => "btn btn-follow btn-inactive btn-follow-placeholder",
        :title => "Please sign in or join now to follow this user."
    end
  end

  def total_earnings
    # TODO: Caching
    sold_items = current_user.items.sold
    if sold_items.any?
      # TODO: Should this be item price + shipping or just price?
      earnings = sold_items.sum(&:price)
      earnings - ((earnings * CLOSET_GROUPIE_PERCENTAGE) + (sold_items.size * CLOSET_GROUPIE_FLAT_FEE))
    else
      0
    end
  end

  def url_for_image(source)
    "#{image_path(source)}"
  end

  def user_favorites_link
    if current_user.present?
      link_to favorites_path do
        "Favorites".html_safe + content_tag(:span,
          current_user.favorites.size,
          :id => "nav_favorites_count",
          :class => "count corners-all")
      end
    end
  end

  def visually_hidden(text)
    content_tag :span, text, :class => "visuallyhidden"
  end

  private

    def favorite_button_for(item)
      link_to "Favorite", favorite_item_path(item.id), id: "fav_btn_#{item.id}",
        :class => "toggle-favorite btn btn-favorite btn-full btn-favorite-long",
        :method => :post
    end

    def unfavorite_button_for(item)
      link_to "Unfavorite", favorite_item_path(item.id), id: "fav_btn_#{item.id}",
        :class => "toggle-favorite btn btn-full btn-unfavorite-long",
        :method => :delete
    end

    def follow_button_for(target)
      link_to "Follow", follow_profile_path(target), :class => "toggle-follow btn btn-follow",
        :id => "follow_closet_#{target.id}", method: :post
    end

    def unfollow_button_for(target)
      link_to "Unfollow", follow_profile_path(target), :class => "toggle-follow btn btn-unfollow",
        :id => "unfollow_closet_#{target.id}", method: :delete
    end
end

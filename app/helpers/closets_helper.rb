module ClosetsHelper
  def related_items_for(item)
    items = Item.find_related_items(item)
    other_items = items.shuffle.shift(2)
    render :partial => "closets/related_items", :locals => {
      :items => other_items,
      :closet => closet
    }
  end

  def linked_item_total(closet)
    link_to "#{item_count(closet)}<br />Items".html_safe, closet_path(closet),
      :class => "img-shadow"
  end

  def item_count(closet)
    closet.items.size
  end

  def toggle_follow_link_for(closet)
    if current_user.present? and not current_user.eql? closet.user
    # unless current_user.nil? or current_user.eql? closet.user
      if current_user.followings.include?(closet.user)
        link_to follow_profile_path(closet.user), :class => "follow-button following", :method => "delete" do
          content_tag(:span, "-", :class => "unfollow-icon icon") +
          content_tag(:span, "Unfollow", :class => "unfollow action")
        end
      else
        link_to follow_profile_path(closet.user), :class => "follow-button not-following", :method => "post" do
          content_tag(:span, "+", :class => "follow-icon icon") +
          content_tag(:span, "Follow", :class => "follow action")
        end
      end
    else
      ""
    end
  end
end

module ItemsHelper
  def add_to_cart_link
    if current_user
      button_to "Add to Cart", cart_path, id: "add_to_cart_btn",
        :class => "btn btn-full btn-add-to-cart", method: :post
    else
      link_to "Add to Cart", "#", id: "add_to_cart_placeholder",
        :class => "btn btn-inactive btn-full btn-add-to-cart-placeholder",
        title: "Please sign in or join now to add this item to your cart"
    end
  end

  def ask_a_question_about(item)
    unless item.sold?
    
    end
  end

  def facebook_like_button(url)
    content_tag :div, "", :class => "fb-like", :data => {
      :href => url,
      :layout => "button_count",
      :send => "false",
      :show_faces => "false",
      :width => "93"
    }
  end
  
  def google_plus_button(url)
    content_tag :div, "", :class => "g-plusone", :data => {
      :annotation => "none",
      :href => url,
      :size => "medium"
    }
  end
  
  def pinterest_button(url, image_url, description)
    link_to "http://pinterest.com/pin/create/button/?url=#{u(url)}&media=#{u(url_for_image(image_url))}&description=#{u(description)}",
      :class => "pin-it-button", :count_layout => "none" do
        image_tag "//assets.pinterest.com/images/PinExt.png", border: 0, title: "Pin It"
    end
  end

  def email_button
    link_to image_tag("pixel.gif", :alt => "Share by e-mail"), "",
      :class => "addthis_button_email icon share-email"
  end
  
  def facebook_share_button(url = '', text = '')
    # TODO: urlencode?
    link_to "Share via Facebook", "https://www.facebook.com/sharer.php?u=#{url}",
      onclick: "return fbshare('#{url}', '#{text}');", :class => "icon share-facebook"
  end
  
  def tweet_button(url = '', text = 'Love this!', via = 'ClosetGroupie')
    # TODO: urlencode link + text?
    link_to "Share via Twitter",
      "https://twitter.com/intent/tweet?text=#{text}&url=#{url}&via=#{via}",
      :class => "icon share-twitter"
  end
end

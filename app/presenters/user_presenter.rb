class UserPresenter < BasePresenter
  VALUE_NOT_GIVEN = "<span class='missing'>Not specified</span>".html_safe

  presents :user

  def biography
    user.biography.presence || VALUE_NOT_GIVEN
  end

  def facebook
    h.link_to "Friend me on Facebook", facebook_url, target: "_blank", rel: "external"
  end

  def location
    user.location.presence || VALUE_NOT_GIVEN
  end

  def member_since
    user.created_at.to_date.to_s(:long) 
  end

  def twitter
    h.link_to "Follow me on Twitter", twitter_url, target: "_blank", rel: "external"
  end

  def website
    if user.website.present?
      h.link_to user.website, user.website, rel: "external", target: "_blank"
    else
      VALUE_NOT_GIVEN
    end
  end

  private
    def facebook_url
      "http://facebook.com/profile.php?id=#{user.facebook_id}"
    end

    def twitter_url
      "http://twitter.com/#{user.twitter_handle}"
    end
end

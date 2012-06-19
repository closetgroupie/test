class ClosetListPresenter < BasePresenter
  presents :closet
  delegate :id, :user, to: :closet

  def linked_avatar
    h.link_to h.image_tag(user_avatar, :class => "profile"), url
  end

  def url
    h.closet_path(closet)
  end

  def user_avatar
    closet.user.avatar_url(:large)
  end

  def to_partial_path
    "closets/closet"
  end
end

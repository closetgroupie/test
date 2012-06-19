class FavoritePresenter < BasePresenter
  presents :favorite
  delegate :item, to: :favorite

  def linked_title
    h.content_tag :h3, h.link_to(h.truncate(item.title, length: 30), h.item_path(item))
  end

  def item_size
    item.size || "N/A"
  end

  def item_price
    h.number_to_currency(item.price)
  end
  
  def sold?
    item.sold?
  end
end

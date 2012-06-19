module ShopHelper
  def classes_for_item(item)
    # TODO: Caching or something else
    classes = []
    classes << item.category.slug.downcase
    classes << "sold-item" if item.sold?
    classes.join(" ")
  end
 
  def merge_to_querystring(key, value)
    # TODO: Make it sane
    key = key.to_s
    values = params.fetch(key, []) + [value.to_s]
    params.merge({key => values.uniq})
  end

  def querystring_minus(key, value)
    # TODO: lol.
    key = key.to_s
    values = params.fetch(key, []) - [value.to_s]
    params.merge({key => values.uniq}) unless values.empty?
  end
end

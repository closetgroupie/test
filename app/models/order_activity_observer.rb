class OrderActivityObserver < BaseActivityObserver
  observe :order

  def after_create(model)
    model.items.each do |item|
      create(model.buyer, model, item)
      FacebookWorker.perform_async('item_sold', {'user' => model.user.id, 'item' => item.id})
    end
  end

  def after_destroy(model)
  end
end

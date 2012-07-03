class OrderObserver < ActiveRecord::Observer
  def after_create(model)
    model.items.each do |item|
      FacebookWorker.perform_async('item_sold', {'user' => model.seller_id, 'item' => item.id})
    end
  end
end

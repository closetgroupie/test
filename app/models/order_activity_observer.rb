class OrderActivityObserver < BaseActivityObserver
  observe :order

  def after_create(model)
    model.items.each do |item|
      create(model.buyer, model, item)
    end
  end

  def after_destroy(model)
  end
end

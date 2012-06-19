class ItemActivityObserver < BaseActivityObserver
  observe :item

  def after_create(model)
    create(model.user, model, model)
  end
  
  def after_destroy(model)
    delete(model.user, model, model)
  end
end

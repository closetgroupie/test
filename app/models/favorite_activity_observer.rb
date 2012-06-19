class FavoriteActivityObserver < BaseActivityObserver
  observe :favorite
  
  def after_create(model)
    create(model.user, model, model.item)
  end

  def after_destroy(model)
    delete(model.user, model, model.item)
  end
end

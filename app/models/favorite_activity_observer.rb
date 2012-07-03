class FavoriteActivityObserver < BaseActivityObserver
  observe :favorite
  
  def after_create(model)
    create(model.user, model, model.item)
    FacebookWorker.perform_async('add_favorite', {'user' => model.user.id, 'item' => model.item.id})
    #f = FacebookWorker.new
    #f.perform('add_favorite', {:user => model.user.id, :item => model.item.id})
  end

  def after_destroy(model)
    delete(model.user, model, model.item)
  end
end

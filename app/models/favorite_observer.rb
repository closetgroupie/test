class FavoriteObserver < ActiveRecord::Observer
  def after_create(model)
    FacebookWorker.perform_async('add_favorite', {'user' => model.user.id, 'item' => model.item.id})
  end
end

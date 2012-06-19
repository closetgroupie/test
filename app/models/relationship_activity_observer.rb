class RelationshipActivityObserver < BaseActivityObserver
  observe :relationship

  def after_create(model)
    create(model.user, model, model.target)
  end

  def after_destroy(model)
    delete(model.user, model, model.target)
  end
end

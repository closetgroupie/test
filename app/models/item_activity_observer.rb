class ItemActivityObserver < BaseActivityObserver
  observe :item

  def after_create(model)
    create(model.user, model, model)

    model.user.groupies.each do |groupie| # har har
      # TODO: Queue
      ItemMailer.new_item_email(model.id, groupie.id).deliver
    end
  end
  
  def after_destroy(model)
    delete(model.user, model, model)
  end
end

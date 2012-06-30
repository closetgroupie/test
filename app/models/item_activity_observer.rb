class ItemActivityObserver < BaseActivityObserver
  observe :item

  def after_create(model)
    create(model.user, model, model)

    model.user.groupies.each do |groupie| # har har
      ItemMailer.delay.new_item_email(model.id, groupie.id)
    end
  end
  
  def after_destroy(model)
    delete(model.user, model, model)
  end
end

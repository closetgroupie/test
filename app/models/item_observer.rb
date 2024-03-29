class ItemObserver < ActiveRecord::Observer
  def after_create(model)
    model.user.groupies.each do |groupie| # har har
      ItemMailer.delay.item_of_interest_email(model.id, groupie.id)
    end

    FacebookWorker.perform_async('sell_item', {'user' => model.user.id, 'item' => model.id})
  end   
end

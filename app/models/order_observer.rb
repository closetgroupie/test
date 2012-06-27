class OrderObserver < ActiveRecord::Observer
  def after_create(model)
    OrderMailer.sale_made_email(model).deliver

    purchase = Cart.where(user_id: model.buyer_id, purchased_at: model.purchased_at)
    OrderMailer.purchase_made_email(purchase).deliver
  end
end

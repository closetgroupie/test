class OrderObserver < ActiveRecord::Observer
  def after_create(model)
    OrderMailer.sale_made_email(model).deliver
  end
end

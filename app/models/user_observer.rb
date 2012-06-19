class UserObserver < ActiveRecord::Observer
  def after_create(model)
    # TODO: Can we do something better here?
    model.create_closet({ name: "#{model.name}'s Closet" })
  end
end

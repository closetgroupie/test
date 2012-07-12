class CuratorApplicationObserver < ActiveRecord::Observer
  def after_create(model)
    CuratorApplicationMailer.delay.new_curator_signup(model.id)
  end
end

class RelationshipObserver < ActiveRecord::Observer
  def after_create(model)
    UserMailer.delay.new_follower_email(model.id)
  end
end

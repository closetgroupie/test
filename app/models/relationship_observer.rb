class RelationshipObserver < ActiveRecord::Observer
  def after_create(model)
    # TODO: Queueing?
    UserMailer.new_follower_email(model.id).deliver
  end
end

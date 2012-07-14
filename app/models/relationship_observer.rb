class RelationshipObserver < ActiveRecord::Observer
  def after_create(model)
    UserMailer.delay.new_follower_email(model.id)
    FacebookWorker.perform_async('follow', {'user' => model.user_id, 'followee' => model.target_id})
  end
end

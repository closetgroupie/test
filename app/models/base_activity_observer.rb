class BaseActivityObserver < ActiveRecord::Observer
  private

    def create(user, action, entity)
      Activity.create(:user => user,
                      :action => action,
                      :entity => entity)
    end

    def delete(user, action, entity)
      activity = Activity.where(
        :user_id => user,
        :action_id => action.id,
        :action_type => action.class.name,
        :entity_id => entity.id,
        :entity_type => entity.class.name
      ).first

      if activity.present?
        activity.destroy
      end
    end
end

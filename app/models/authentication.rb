class Authentication < ActiveRecord::Base
  belongs_to :user

  attr_accessible :user_id, :provider, :uid

  def current?
    case provider
    when "facebook"
      created_at > 60.days.ago
    when "twitter"
      # TODO: Does twitter expire tokens?
      true
    end
  end
end

class Authentication < ActiveRecord::Base
  belongs_to :user

  validates :uid, :presence => true, :uniqueness => { :scope => :provider }
  attr_accessible :user_id, :provider, :uid, :access_token

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

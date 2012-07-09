class AdminConstraint
  def self.matches?(request)
    # TODO: Is this good/secure enough, or should we go all out here?
    if request.session and request.session[:user_id]
      user = User.find(request.session[:user_id])
      return (user.present? and user.admin?)
    else
      return false
    end
  end
end

class AuthenticatedConstraint
  def self.matches?(request)
    # TODO: Is this good/secure enough, or should we go all out here?
    if request.session and request.session[:user_id]
      user = User.find(request.session[:user_id])
      return user.present?
    else
      return false
    end
  end
end

class NotInProductionConstraint
  def self.matches?(request)
    return !Rails.env.production?
  end
end

class SegmentConstraint
  def self.matches?(request)
    SHOPPING_SEGMENTS.include?(request.params[:segment].downcase)
  end
end

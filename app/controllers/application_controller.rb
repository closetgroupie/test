class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_cart
    if current_user
      if session[:cart_id]
        @current_cart ||= Cart.where(:id => session[:cart_id]).first
        session[:cart_id] = nil if @current_cart.nil? || @current_cart.purchased_at?
      end
      if session[:cart_id].nil?
        @current_cart = current_user.cart.where(purchased_at: nil).first_or_create
        session[:cart_id] = @current_cart.id
      end
      # XXX: Load cart items?
      @current_cart
    # TODO: else..?
    end
  end

  def current_order
    @current_order ||= order_from_session
  end

  def urls
    Rails.application.routes.url_helpers
  end

  helper_method :current_order, :current_cart
  private

    def require_admin
      unless current_user and current_user.admin?
        raise ActionController::RoutingError.new('Not Found')
      end
    end

    def order_from_session
      if current_user.present?
        @current_order = (Order.find_by_id(session[:order_id]) if session[:order_id]) || nil
      else
        nil
      end
    end
    
    def legacy_login(email, password)
      user = Legacy::Login.authenticate(email, password)
    end
end

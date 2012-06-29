class CartsController < ApplicationController
  include ActiveMerchant::Billing::Integrations
  before_filter :require_login, only: :show

  skip_before_filter :before_login, only: :paypal_ipn
  skip_before_filter :verify_authenticity_token, only: :paypal_ipn

  def show
    @cart = current_cart
    @closet_grouped_items = current_cart.items_grouped_by(:closet)
  end

  def paypal_ipn
    notify = PaypalAdaptivePayment::Notification.new(request.raw_post)
    @cart = Cart.identified_by(notify.params["tracking_id"] || "").first
    # Verify from PayPal that this is an actual notification from them.
    if notify.acknowledge
      begin
        currency, amount = notify.amount.split
        # TODO: Don't convert to_f, rather do decimals, or something..
        if notify.complete? and @cart.total == BigDecimal.new(amount)
          # Mark cart complete, notify sellers, mark items sold.
          @cart.convert_to_orders
        else
          logger.error "SEVERE: Paypal IPN successfully received but there was an error processing it!"
          logger.error "IPN REQUEST: #{notify}"
          logger.error "Cart: #{@cart}"
        end
      rescue => e
        logger.error "SEVERE: Paypal IPN successfully received but there was an error processing it!"
        logger.error "IPN REQUEST: #{notify}"
        logger.error "Cart: #{@cart}"
        logger.error "Exception: #{e}"
        logger.error "#{$@}"
      end
    end
    render nothing: true
  end
end

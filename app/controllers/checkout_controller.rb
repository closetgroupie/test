class CheckoutController < ApplicationController
  include Wicked::Wizard

  steps :shipping, :payment

  def create
    # TODO: Change state?
    redirect_to cart_checkout_index_url
  end

  def complete
    # TODO: Validate that the user has actually began checkout, maybe based on cart.state?
    @cart = current_cart
    redirect_to root_url unless @cart.items.includes(:photos).any? and @cart.unique_id?
  end

  def show
    # TODO: Fetch whatever object (order?) that we are manipulating/adding on to
    case step
    when :shipping
      @addresses = current_user.addresses
      @address = Address.new
    end
    render_wizard
  end

  def update
    case step
    when :shipping
      @address = find_or_create_address_from(params[:address])
      current_cart.shipping_address = @address
    when :payment
      gateway =  ActiveMerchant::Billing::PaypalAdaptivePayment.new(Closetgroupie::Application.config.paypal.except(:email))

      recipients = current_cart.generate_recipients

      uid = current_cart.generate_unique_id
      response = gateway.setup_purchase(
        :return_url           => complete_cart_checkout_index_url,
        :cancel_url           => cart_url,
        :ipn_notification_url => ipn_for_cart_url(current_cart),
        :receiver_list        => recipients,
        :tracking_id          => uid,
        :custom               => uid,
        :fees_payer           => 'EACHRECEIVER'
      )
      binding.pry
    end

    if step == :payment
      # TODO: Change this once we have more methods
      redirect_to(gateway.redirect_url_for(response["payKey"]))
    else
      render_wizard current_cart
    end
  end

  private

  def find_or_create_address_from(address_hash)
    # TODO: Validate address
    address = current_user.addresses.first_or_initialize(address_hash)
    address.save if address.new_record?
    address
  end
end

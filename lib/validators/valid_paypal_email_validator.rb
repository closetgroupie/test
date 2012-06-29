class ValidPaypalEmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    response = verify_paypal_address(value)
    record.errors[attribute] = "PayPal e-mail was invalid." unless response.success?
  end

  def verify_paypal_address(email)
    gateway =  ActiveMerchant::Billing::PaypalAdaptivePayment.new(Closetgroupie::Application.config.paypal.except(:email))

    recipients = []

    recipients << {
      :email => Closetgroupie::Application.config.paypal[:email],
      :amount => 1.00,
      :primary => true
    }

    recipients << {
      :email => email,
      :amount => 1.00,
      :primary => false
    }

    uid = "TEST-#{Time.now.to_i}"

    settings_paypal_url = Rails.application.routes.url_helpers.settings_paypal_url(:host => "https://closetgroupie.com")

    request = gateway.setup_purchase(
      :return_url           => settings_paypal_url,
      :cancel_url           => settings_paypal_url,
      :ipn_notification_url => settings_paypal_url,
      :receiver_list        => recipients,
      :tracking_id          => uid,
      :custom               => uid,
      :fees_payer           => 'EACHRECEIVER'
    )

    return request
  end
end

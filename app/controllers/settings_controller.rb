class SettingsController < ApplicationController
  layout "dashboard"

  before_filter :require_login

  # TODO: Make use of rails_config here
  FLASH_MESSAGES = {
    :email => "Your e-mail was updated successfully.",
    :password => "Your new password was updated successfully.",
    :paypal => "Your PayPal e-mail was updated successfully.",
    :profile => "Your profile was updated successfully.",
    :address => "Your shipping address was updated successfully."
  }

  def index
    # TODO: Switch to an actual frontpage of some sort...
    redirect_to settings_profile_url
  end

  def update
    @action = get_action_or_default(params)
    @user = current_user.id
    if current_user.update_attributes(params[:user])
      begin
        redirect_to :back, :notice => flash_for_action(@action) 
      rescue ActionController::RedirectBackError
        redirect_to settings_url
      end
    else
      if @action.present?
        render @action.to_sym
      else
        redirect_to settings_url
      end
    end
  end

  def address
  end

  def closet
    @closet = current_user.closet
  end

  def email
    @user = User.new
  end

  def notifications
  end

  def password
  end

  def paypal
  end

  def profile
    @user = current_user
  end

  private

  def flash_for_action(action)
    FLASH_MESSAGES.fetch(action, "Your settings were updated successfully.")
  end

  def get_action_or_default(params)
    @action = params.fetch(:action_view, "update")
  end

  def verify_paypal_address(params)
    # TODO: Add a method that calls a service for verifying the address, asynchonously maybe?
  end
end

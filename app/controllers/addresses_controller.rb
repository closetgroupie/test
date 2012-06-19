class AddressesController < ApplicationController
  layout "dashboard"

  def index
    @address = Address.new
    @addresses = current_user.addresses
  end

  def create
    @shipping_address = current_user.addresses.build(params[:address])
    if @shipping_address.save
      redirect_to settings_addresses_url #, :notice => "Created successfully"?
    else
      # flash?
      render :index
    end
  end

  def destroy
    if current_user.addresses.destroy(params[:id])
      flash.notice = "Shipping Address deleted"
    else
      flash.alert = "Unable to delete the Shipping Address"
    end
    redirect_to settings_addresses_url
  end
end

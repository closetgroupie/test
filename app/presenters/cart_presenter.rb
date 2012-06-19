class CartPresenter < BasePresenter
  presents :cart

  delegate :orders, :total, :unique_id, to: :cart

  def shipping
    @shipping ||= cart.shipping_address
  end
end

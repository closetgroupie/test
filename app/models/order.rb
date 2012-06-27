class Order < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy
  has_many :items, :through => :line_items

  belongs_to :cart
  belongs_to :seller, :class_name => "User"
  belongs_to :buyer, :class_name => "User"

  has_many :conversations, :as => :conversable

  attr_accessible :buyer_id, :seller_id, :purchased_at

  # TODO: CONSOLIDATE ALL OF THESE METHODS IN TO A SINGLE PORO CLASS

  def closetgroupie_fee
    (total_without_shipping * CLOSET_GROUPIE_PERCENTAGE) + (items.size * CLOSET_GROUPIE_FLAT_FEE)
  end

  def total_without_shipping
    items.inject(0) { |sum, i| sum + i.price }
  end

  def total
    items.inject(0) { |sum, i| sum + i.price + i.shipping_cost }
  end

  def total_earned
    total - closetgroupie_fee
  end

  def self.between(buyer, seller)
    where(:buyer_id => buyer.id, :seller_id => seller.id)
  end

  def self.cart_for(user)
    where(:buyer_id => user)
  end

  def self.purchases_by(user)
    where(:buyer_id => user)
  end

  def self.sales_by(user)
    where(:seller_id => user)
  end

  def unique_id
    "CG-SO-#{id}-#{created_at.to_i}"
  end

  #TODO TRES remove this, figure out how to use OrderPresenter in purchase_made_email
  def shipping
    @shipping ||= cart.shipping_address
  end

end

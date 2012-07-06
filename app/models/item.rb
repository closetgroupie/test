class Item < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  default_scope order("sold ASC, id DESC")

  paginates_per 40

  belongs_to :user
  belongs_to :closet

  belongs_to :size
  belongs_to :brand

  belongs_to :segment
  belongs_to :category

  has_many :conversations, :as => :conversable
  has_many :favorites

  has_many :photos, :dependent => :destroy
  has_one :hero_image, :class_name => "Photo", :order => "ordering DESC, id ASC"

  has_one :line_item, :include => :order
  has_one :active_order, :through => :line_item, :source => :order

  validates :segment_id, :category_id, :condition, :title, :price, :shipping_cost, :photos, :presence => true
  validate :must_have_at_least_one_photo

  accepts_nested_attributes_for :photos, :allow_destroy => true

  attr_accessible :segment_id,
                  :category_id,
                  :size_id,
                  :condition,
                  :brand_id,
                  :brand_suggestion,
                  :title,
                  :description,
                  :price,
                  :shipping_abroad,
                  :shipping_cost,
                  :shipping_cost_bundled,
                  :shipping_from,
                  :shipping_notes,
                  :photos_attributes

  ATTRS_SAFE_FOR_UPDATE = %w(
    brand_id
    brand_suggestion
    category_id
    condition
    description
    price
    segment_id
    shipping_cost
    shipping_cost_bundled
    shipping_from
    shipping_notes
    size_id
    title
  )

  CONDITIONS = {
    "Brand New" => 1,
    "Worn Once" => 2,
    "Good"      => 3,
    "Well Worn" => 4,
    "Terrible"  => 5
  }

  def brand_name
    brand.try(:name) || try(:brand_suggestion) || "N/A"
  end

  def must_have_at_least_one_photo
    errors.add(:photos, "At least one photo is required.") if no_photos?
  end

  def no_photos?
    photos.empty? or photos.all? { |p| p.marked_for_destruction? }
  end

  def belongs_to_any_cart?
    # TODO: Should this be active_order instead?
    line_item.present?
  end

  def belongs_to_user_order?(user)
    active_order.present? and active_order.buyer == user
  end

  def fees_for_price
    # TODO: This should come from a constant, do proper currency calculation
    (price * CLOSET_GROUPIE_PERCENTAGE) + CLOSET_GROUPIE_FLAT_FEE
  end

  def has_photos?
    photos.any?
  end

  def self.by_segments(segments)
    where(:segment_id => segments)
  end

  def self.by_category(category)
    where(:category_id => category.id)
  end

  def self.filter_by(segments = nil, category = nil, sizes = [])
    chain = where(:segment_id => segments)
    chain = chain.where(:category_id => category) if category.present?
    chain = chain.where(:size_id => sizes) if sizes.any?
    chain
  end

  def self.find_related_items(item)
    items = where(closet_id: item.closet_id).limit(30)
  end

  def self.selling
    where(:sold => false)
  end

  def self.sold
    where(:sold => true)
  end

  def self.unsold
    where(:sold => false)
  end

  def self.sold_by(user)
    where(user_id: user.id, sold: true)
  end

  def price_with_shipping
    price - fees_for_price + shipping_price
  end

  def shipping_price
    # TODO: Logic for when there's more than one item and bundle price?
    shipping_cost
  end

  def to_indexed_json
    {
      image: photos.first.image_url(:search),
      title: title,
      price: price,
      size: size.to_s
    }.to_json if photos.any?
  end

  def safe_update(params)
    ATTRS_SAFE_FOR_UPDATE.each do | field |
      value = params[ field ]
      send("#{ field }=".to_sym, value ) unless value.nil?
    end
  end
end

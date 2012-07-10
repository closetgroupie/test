class Cart < ActiveRecord::Base
  belongs_to :user
  belongs_to :purchase

  belongs_to :billing_address,  class_name: "Address"
  belongs_to :shipping_address, class_name: "Address"

  has_many :orders
  has_many :line_items
  has_many :items, through: :line_items

  attr_accessible :purchased_at

  def contains?(item)
    items.any? { |i| i.id == item.id }
  end

  def self.for_user(user)
    where(:user_id => user.id)
  end

  def self.purchases_by(user)
    # TODO: Is there a more rails-y way to do this? AREL?
    where("user_id = ? AND purchased_at IS NOT NULL", user.id)
  end

  def self.identified_by(unique_id)
    if unique_id.present?
      parts = unique_id.split("-")
      id, timestamp = parts[2].to_i, parts[3]
      # dt = DateTime.strptime(timestamp, "%s")
      # TODO: Add querying by the timestamp
      where(id: id)
    end
  end

  def has_items?
    not item_count.zero?
  end

  def item_count
    items.unsold.size
  end

  def total
    # TODO: Take in to account bundled package costs, etc.
    line_items.inject(0) { |sum, li| sum + li.price + li.shipping_cost }
  end

  # TODO: Move to a separate class, doesn't belong here
  def convert_to_orders
    purchased_at = Time.zone.now
    line_items.includes(:item).each do |li|
      # TODO: Do this in memory
      order = Order.where(buyer_id: user_id, seller_id: li.item.user_id, purchased_at: purchased_at) \
                         .first_or_initialize(buyer_id: user_id, seller_id: li.item.user_id)
      order.line_items << li
      li.item.update_attribute(:sold, true)
      order.purchased_at = purchased_at unless order.persisted?
      orders << order unless orders.include? order
      order.save
    end
    orders.each do |order|
      OrderMailer.delay.sale_made_email(order.id)
      ReminderSchedulingWorker.perform_async(order.id) # Schedule review reminder
    end
    update_attribute(:purchased_at, purchased_at)
    save
  end

  def items_grouped_by(grouping_by = :user)
    items.unsold.includes(:user, :closet).group_by(&grouping_by)
  end

  def generate_recipients
    # TODO: Refactor? This is probably a bit inefficient
    recipients = []

    recipients << {
      :email => Closetgroupie::Application.config.paypal[:email],
      :amount => total.round(2), # TODO switch to money gem?
      :primary => true
    }

    items_grouped_by(:user).each do |user, items|
      # TODO: What about bundled shipping?
      recipients << {
        :email   => user.paypal_email,
        :amount  => items.sum(&:price_with_shipping).round(2), # TODO switch to money gem?
        :primary => false
      }
    end

    recipients
  end

  def generate_unique_id
    timestamp = Time.zone.now.to_i
    uid = "CG-PO-#{id}-#{timestamp}"
    update_attribute(:unique_id, uid)
    uid
  end

  def to_s
    "#<Cart: id: #{id}, user: #{user.id}>"
  end

end

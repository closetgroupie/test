module MetricsMailerHelper
  class Count
    def initialize(model_class)
      @model = model_class
    end

    def total
      @model.count
    end

    def since(time_ago, format = :count)
      count = between(time_ago, Time.now)
      case format
      when :count
        count
      when :percent # percent change relative to total user base
        count.to_f / total.to_f * 100
      end
    end

    def between(start_time, end_time)
      @model.count(:conditions => "created_at > to_timestamp(#{start_time.to_i}) AND created_at < to_timestamp(#{end_time.to_i})")
    end
  end

  class MoneyMetrics
    def self.total
      (Order.where("purchased_at IS NOT NULL").inject(0) { |sum, i| sum + i.total_without_shipping }).to_f
    end

    def self.purchase_total_since(time_ago, format = :amount)
      amount = self.purchase_total_between(time_ago, Time.now)
      case format
      when :amount
        amount.to_f
      when :percent
        amount.to_f / self.total.to_f * 100
      end
    end

    def self.purchase_total_between(start_time, end_time)
      # TODO this is really inefficient... we should probably be storing a total column
      # in the database under Cart and Order
      orders = Order.where("purchased_at > to_timestamp(#{start_time.to_i}) AND purchased_at < to_timestamp(#{end_time.to_i})")
      amount = orders.inject(0) { |sum, i| sum + i.total_without_shipping }
      amount.to_f
    end
  end

end

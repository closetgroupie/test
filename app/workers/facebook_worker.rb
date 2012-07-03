class FacebookWorker
  include Sidekiq::Worker
  include FacebookHelper
  include Rails.application.routes.url_helpers

  def perform(action, param)
    @user = User.find param['user']
    @namespace = Rails.application.config.og_namespace
    if @user and @user.has_facebook?
      @graph = get_graph(@user)
      if @graph
        case action
        when 'add_favorite'
          if Rails.configuration.publish_favorites
            add_favorite(param)
          end
        when 'sell_item'
          if Rails.configuration.publish_new_item_listings
            sell_item(param)
          end
        when 'item_sold'
          if Rails.configuration.publish_sales
            item_sold(param)
          end
        when 'item_purchased'
          if Rails.configuration.publish_purchases
            item_purchased(param)
          end
        when 'follow'
          if Rails.configuration.publish_follows
            follow(param)
          end
        end
      end
    end
  end

  def add_favorite(param)
    item = Item.find param['item']
    if item
      @graph.put_connections("me", "#{@namespace}:favorite", :item => item_url(item, :host => Rails.application.config.root_url))
    end
  end

  def sell_item(param)
    item = Item.find param['item']
    if item
      # Setting a distant future end time so Facebook views it
      # as a currently happening event
      args = {:item => item_url(item,:host => Rails.application.config.root_url), :start_time => Time.now.to_i, :end_time => 10.years.from_now.to_i}
      i = @graph.put_connections("me", "#{@namespace}:sell", args)
    end
  end

  def item_sold(param)
    item = Item.find param['item']
    if item
      # end time is now, so activity will appear as past tense
      args = {:item => item_url(item,:host => Rails.application.config.root_url), :start_time => Time.now.to_i}
      i = @graph.put_connections("me", "#{@namespace}:sell", args)
    end
  end

  def item_purchased(param)
    item = Item.find param['item']
    if item
      args = {:item => item_url(item, :host => Rails.application.config.root_url) }
      @graph.put_connections("me", "#{@namespace}:buy", args)
    end
  end

  def follow(param)
    followee = User.find param['followee']
    if followee
      args = {:member => closet_url(followee.closet, :host => Rails.application.config.root_url) }
      @graph.put_connections("me", "#{@namespace}:follow", args)
    end
  end
end

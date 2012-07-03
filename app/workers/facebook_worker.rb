class FacebookWorker
  include Sidekiq::Worker
  include FacebookHelper
  include Rails.application.routes.url_helpers

  def perform(action, param)
    @user = User.find param['user']
    if @user and @user.has_facebook?
      @item = Item.find param['item']
      @graph = get_graph(@user)
      if @item and @graph
        case action
        when 'add_favorite'
          add_favorite
        when 'sell_item'
          sell_item
        when 'item_sold'
          item_sold
        when 'item_bought'
          item_bought
        end
      end
    end
  end

  def add_favorite
    @graph.put_connections("me", "closetgroupie-dev:favorite", :item => item_url(@item, :host => Rails.application.config.root_url))
  end

  def sell_item
    # Setting a distant future end time so Facebook views it
    # as a currently happening event
    args = {:item => item_url(@item,:host => Rails.application.config.root_url), :start_time => Time.now.to_i, :end_time => 10.years.from_now.to_i}
    i = @graph.put_connections("me", "closetgroupie-dev:sell", args)
  end

  def item_sold
    # end time is now, so activity will appear as past tense
    args = {:item => item_url(@item,:host => Rails.application.config.root_url), :start_time => Time.now.to_i}
    i = @graph.put_connections("me", "closetgroupie-dev:sell", args)
    binding.pry_remote
  end

  def item_bought
    args = {:item => item_url(@item,:host => Rails.application.config.root_url) }
    @graph.put_connections("me", "closetgroupie-dev:buy", args)
  end
end

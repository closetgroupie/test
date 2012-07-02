class FacebookWorker
  #include Sidekiq::Worker
  include FacebookHelper
  include Rails.application.routes.url_helpers

  def perform(action, param)
    puts action.class, action, param
    case action
    when 'add_favorite'
      add_favorite(param)
    end
  end

  def add_favorite(param)
    u = User.find(param[:user])
    i = Item.find(param[:item])
    if u.has_facebook?
      g = get_graph(u)
      binding.pry
      g.put_connections("me", "closetgroupie-dev:Favorite", :object => item_url(i, :host => Rails.application.config.root_url))
    end
  end
end

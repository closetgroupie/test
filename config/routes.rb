Closetgroupie::Application.routes.draw do
  get "oauths/oauth"

  get "oauths/callback"

  get "signup" => "users#new", :as => "signup"
  post "signup" => "users#create", :as => "signup"
  get "logout" => "sessions#destroy", :as => "logout"
  get "login"  => "sessions#new", :as => "login"

  # controller :users, :path => "/signup" do
  #   get  "" => :new, :as => "signup"
  #   post "" => :create, :as => "users"
  # end

  get  "forgot-password"     => "password_resets#new",    as: "forgot_password"
  post "forgot-password"     => "password_resets#create", as: "forgot_password"
  get  "forgot-password/:id" => "password_resets#edit",   as: "edit_forgot_password"
  put  "forgot-password/:id" => "password_resets#update", as: "update_forgot_password"

  # TODO: Revisit these, should /profile redirect to /profile/:id for current_user?
  resources :profile, :controller => :users, :only => [:show] do
    member do
      post   "follow" => "relationships#create"
      delete "follow" => "relationships#destroy"
    end
  end

  # TODO: Revisit these, since users is scattered all over the place.
  resources :users, :except => [:new, :create, :show]

  resources :closets, except: [:index] do
    resources :reviews, :only => [:index, :new, :create]
    get "following" => "closets#following", :on => :collection
    get "friends"   => "closets#friends", :on   => :collection
  end

  resources :favorites, only: :index
  resources :conversations, path: '/messages' do
    post "/reply" => "conversations#reply", :on => :member
  end
  resources :sessions

  get "following(/:id)" => "relationships#index", as: :following,
    defaults: { relationship_type: :followings }
  get "groupies(/:id)"  => "relationships#index", as: :groupies,
    defaults: { relationship_type: :groupies }
  get "search"    => "search#index"

  resources :friends, only: [:index, :create, :new], path_names: { new: "invite" }

  resources :items, except: [:index], path_names: { new: "add" } do 
    member do
      get "question" => "conversations#new", defaults: { type: "Item" }
      post "question" => "conversations#create", defaults: { type: "Item" }
      post "favorite" => "favorites#create"
      delete "favorite" => "favorites#destroy"
    end

    collection do
      # TODO: Should this be "available_items_path" instead?
      get "selling"
      get "sold"
    end
  end

  resources :photos do
    post 'rotate_clockwise', :on => :member
    post 'rotate_counterclockwise', :on => :member
  end

  match "oauth/callback" => "oauths#callback"
  match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  # cart has many items
  # upon "checkout" cart items are transferred to order(?)
  resource :cart, :only => [:show] do
    post ":id/ipn" => :paypal_ipn, as: :ipn_for
    resources :checkout, :only => [:index, :create, :show, :update] do
      get "complete" => :complete, :on => :collection
    end
    resources :line_items, :only => [:create, :destroy], path: :item
  end

  get "purchases" => "purchases#index", defaults: { type: :purchases}
  get "purchases/:id" => "purchases#show", defaults: { type: :purchases }, as: "purchase"
    get  "purchases/:id/contact" => "conversations#new", defaults: { type: "Order" }, as: "contact_seller"
    post "purchases/:id/contact" => "conversations#create", defaults: { type: "Order" }
  get "sales"     => "orders#index", defaults: { type: :sales }
  get "sales/:id" => "orders#show", defaults: { type: :sales }, as: "sale"
    get  "sales/:id/contact" => "conversations#new", defaults: { type: "Order" }, as: "contact_buyer"
    post "sales/:id/contact" => "conversations#create", defaults: { type: "Order" }


  get "search" => "search#index"

  # In case we need to enable many more actions within the settings, use this:
  # match "/settings(/:action)", :controller => 'settings', :action => 'profile'
  scope :path => '/settings', :controller => 'settings', :as => 'settings' do
    get ""              => :index
    put ""              => :update
    resources :addresses
    # get "address"       => :address
    get "closet"        => :closet
    get "email"         => :email
    get "notifications" => :notifications
    get "profile"       => :profile
    get "password"      => :password
    get "paypal"        => :paypal
  end

  get "terms"   => "static#terms"
  get "privacy" => "static#privacy"

  get "about"   => "static#about"
  get "team"    => "static#team"
  get "careers" => "static#careers"

  get ":segment"           => "shop#show", constraints: SegmentsRestriction, as: "shop"
  get ":segment/:category" => "shop#show", constraints: SegmentsRestriction, as: "shop_by_category"
  get "/activity/previous/:id" => "activities#previous"
  get "activities" => "activities#feed"

  # Legacy URLs
  get "item-details/:legacy_id" => "legacy_redirects#item_details"
  get "item-details/:legacy_id/:dontcare" => "legacy_redirects#item_details"
  get "closet/:legacy_id"       => "legacy_redirects#closet"
  get "legacy/image/:item/:image" => "legacy_redirects#item_image"

  root to: "activities#index", constraints: AuthenticatedConstraint
  root to: "landing#index"
end

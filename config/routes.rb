ActionController::Routing::Routes.draw do |map|

  map.login   "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.register "register", :controller => 'users', :action => "new"
  
  map.resources :goals, :collection => {:sidebar => :get}

  map.connect '/twitter', { :controller => 'oauth', :action => 'callback', :method => 'get' }

  map.twitter_login '/login/twitter', {:controller => 'oauth', :action => 'login', :method => 'get'}

  map.resources :entry_matches, :member => {:alternates => :get}
  map.resources :entries

  map.resources :food_items

  map.resource :user_session, :as => "accounts"

  map.resource :account, :controller => "users"
  map.resources :users
  
  map.root :controller => 'static'

  # Default routes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

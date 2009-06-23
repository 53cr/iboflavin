ActionController::Routing::Routes.draw do |map|
  map.resources :invitations


  map.login   "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.register "/register/:invitation_token", :controller => 'users', :action => "new"
  map.register "/register", :controller => 'users', :action => "new"

  map.resources :goals, :collection => {:sidebar => :get}

  map.connect '/twitter', { :controller => 'oauth', :action => 'callback', :method => 'get' }

  map.twitter_login '/login/twitter', {:controller => 'oauth', :action => 'login', :method => 'get'}

  map.resources :entry_matches, :member => {:alternates => :get}
  map.resources :entries

  map.resources :food_items

  map.resource :user_session, :as => "accounts"

  map.disable_sidebar_prompt '/user/disable_prompt', :controller => 'users', :action => 'disable_sidebar_prompt'
  map.resource :account, :controller => "users"
  map.resources :users

  map.root :controller => 'static'

  # Default routes
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

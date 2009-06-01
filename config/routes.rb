ActionController::Routing::Routes.draw do |map|


  map.twitter_login '/twitter_login', { :controller => 'user_sessions', :action => 'create', :method => 'get' }
  map.twitter_register '/twitter_register', { :controller => 'users', :action => 'create', :method => 'get' }
  map.authorize_twitter '/twitter', { :controller => 'oauth', :action => 'authorize', :method => 'get' }

  map.resources :entry_matches
  map.resources :entries

  map.resource :user_session

  map.resource :account, :controller => "users"
  map.resources :users
  
  map.root :controller => 'static'




  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

ActionController::Routing::Routes.draw do |map|
  
  map.connect '/twitter', { :controller => 'oauth', :action => 'callback', :method => 'get' }

  map.twitter_login '/login/twitter', {:controller => 'oauth', :action => 'login', :method => 'get'}

  map.resources :entry_matches
  map.resources :entries

  map.resource :user_session

  map.resource :account, :controller => "users"
  map.resources :users
  
  map.root :controller => 'static'




  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

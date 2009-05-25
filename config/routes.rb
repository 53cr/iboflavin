ActionController::Routing::Routes.draw do |map|

  map.connect '/callback', :controller => 'users', :action => 'callback'

  map.resources :entry_matches
  map.resources :entries

  map.resource :user_session

  map.resource :account, :controller => "users"
  map.resources :users, :collection => {:create_from_twitter => :get, :callback => :get}
  
  map.root :controller => 'static'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

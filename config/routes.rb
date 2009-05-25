ActionController::Routing::Routes.draw do |map|
  map.resources :entry_matches
  map.resources :entries

  map.resource :user_session

  map.resource :account, :controller => "users"
  map.resources :users
  
  map.root :controller => 'static'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

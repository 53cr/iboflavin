ActionController::Routing::Routes.draw do |map|
  map.resources :entry_matches
  map.resources :entries

  map.root :controller => 'static'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

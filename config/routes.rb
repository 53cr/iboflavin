ActionController::Routing::Routes.draw do |map|
  map.resources :entry_matches
  map.resources :entries

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  Chromium53::Routes.add_to(map) 
end

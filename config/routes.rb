ActionController::Routing::Routes.draw do |map|
  map.resources :entry_matches
  map.resources :entries

  Chromium53::Routes.add_to(map) 

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

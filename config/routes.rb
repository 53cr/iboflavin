ActionController::Routing::Routes.draw do |map|
  map.resources :entries

  map.resources :entries

  map.root :controller => 'entries', :action => 'new'
  
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'

  Chromium53::Routes.add_to(map) 
end

ActionController::Routing::Routes.draw do |map|
  %W{ }.each do |page|
    map.connect page, :controller => 'static', :action => page
  end
  
  map.root     :controller => 'static', :action => 'index'
  map.resource :user_session, :as => 'session'
    
  map.login    '/login',    :controller => 'user_sessions', :action => 'new'
  map.logout   '/logout',   :controller => 'user_sessions', :action => 'destroy'
  map.signup   '/signup',   :controller => 'users', :action => 'new'
  map.resource  :session

  map.resource :password do |password|
    password.reset '/reset/:perishable_token', :controller => 'passwords',:action => 'reset'
  end
  
  map.confirmation '/confirm/:perishable_token', :controller => 'users', :action => 'confirm'

  map.resources :users, :as => :teams

  map.dashboard '/dashboard', :controller => 'dashboard'
  map.namespace(:dashboard) do |dashboard|
    dashboard.resource :info, :only => [:show, :edit, :update]
  end
  
  map.admin '/admin', :controller => 'admin'

  map.namespace(:admin) do |admin|
    admin.resources :users
  end
end

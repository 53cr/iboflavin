
class ApplicationController < ActionController::Base
  protect_from_forgery
 
  include HoptoadNotifier::Catcher
  include Chromium53::Authentication::ApplicationController 
end

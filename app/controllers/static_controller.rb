class StaticController < ApplicationController
#  uncomment to enable static caching
#
# caches_page :index                   

  def index
    if @current_user
      redirect_to new_entry_url
    end
  end
  
end

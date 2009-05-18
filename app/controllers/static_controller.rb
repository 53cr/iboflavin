class StaticController < ApplicationController
#  uncomment to enable static caching
#
# caches_page :index

  def index
    
  end

  def add
    @count, @unit, search = Grammar.parse(params[:input])
    @food = FoodItem.search(search,:limit=>1).first
  end
  
end

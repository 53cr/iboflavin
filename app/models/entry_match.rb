require 'lingua/stemmer'

class EntryMatch < ActiveRecord::Base

  before_save :cache_search_terms
  
  belongs_to :entry
  belongs_to :user
  belongs_to :food_item
  
  validates_presence_of :search, :user_id, :entry_id

  private
  def cache_search_terms
    s = Lingua::Stemmer.new
    arr = s.stem(self.search).split(/[\s-]+/)
    self.p2search = arr.join(' ')
    self.p3search = arr.sort.join(' ')

    self.food_item = FoodItem.awesome_search(self.search, self.unit, self.amount)

  end
  
end

class EntryMatch < ActiveRecord::Base

  before_save :cache_search_terms
  
  belongs_to :entry
  belongs_to :user
  belongs_to :food_item
  
  validates_presence_of :search, :user_id, :entry_id

  private
  def cache_search_terms
    self.sigsearch = SearchUtils.signaturize(self.search)
    self.food_item = FoodItem.awesome_search(self.search)
  end
  
end

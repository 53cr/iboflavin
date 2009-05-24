class EntryMatch < ActiveRecord::Base

  before_save :cache_search_terms
  
  belongs_to :entry
  belongs_to :user
  belongs_to :food_item
  
  validates_presence_of :search, :user_id, :entry_id

  def humanize_amount
    roundto = lambda do |n,x|
      (n * 10**x).round.to_f / 10**x
    end

    human_amount = roundto.call(self.amount, 3)
    human_amount = human_amount.to_i if human_amount.to_i == human_amount

    human_unit = self.unit.split('::').last.downcase
    unless human_amount == 1
      human_unit = ActiveSupport::Inflector.pluralize(human_unit)
    end
      
    "#{human_amount} #{human_unit}"
  end

  private
  def cache_search_terms
    self.sigsearch = SearchUtils.signaturize(self.search)
    self.food_item = FoodItem.awesome_search(self.search)
  end
  
end

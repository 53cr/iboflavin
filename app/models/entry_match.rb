class EntryMatch < ActiveRecord::Base

  before_create :find_food_item
  before_save :set_sigsearch
  
  belongs_to :entry
  belongs_to :user
  belongs_to :food_item
  
  validates_presence_of :search, :user_id, :entry_id

  def amount_of_nutrient(nutrient_id)
    begin
      fin = FoodItemNutrient.find_by_food_item_id_and_nutrient_id(self.food_item.id, nutrient_id)
      return fin.amount * standard_mass_multiples
    rescue
      return 0
    end
  end
  
  def standard_mass_multiples
    unit   = self.unit
    amount = self.amount

    return 0 unless self.food_item
    
    if unit == "Grammar::Vocabulary::Serving"
      amount *= self.food_item.serving_size
      unit = self.food_item.serving_size_unit
    end

    # Serving size may be specified in volumetric units.
    if unit == "Grammar::Vocabulary::Litre"
      amount *= (self.food_item.density/1000.0)
      unit = "Grammar::Vocabulary::Gram"
    end

    # Everything is measured in multiples of 100g.
    return amount / 100.0
  end
  
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
  def find_food_item
    self.food_item = (FoodItem.awesome_search(self.user_id,self.search)[0])
  end
  def set_sigsearch
    self.sigsearch = SearchUtils.signaturize(self.search)
  end
  
end

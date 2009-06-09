class EntryMatch < ActiveRecord::Base

  before_create :find_food_item
  before_save :set_sigsearch
  
  belongs_to :entry
  belongs_to :user
  belongs_to :food_item
  
  validates_presence_of :search, :user_id, :entry_id

  def is_today
    self.created_at > Date.today
  end
  
  def amount_of_nutrient(nutrient_id,was=false)
    z_food_item_id = (was ? self.food_item_id_was : self.food_item_id)
    return 0 if z_food_item_id.nil?
    begin
      fin = FoodItemNutrient.find_by_food_item_id_and_nutrient_id(z_food_item_id, nutrient_id)
      return fin.amount * standard_mass_multiples(was)
    rescue
      return 0
    end
  end
  
  def standard_mass_multiples(was=false)
    z_unit   = (was ? self.unit_was : self.unit)
    z_amount = (was ? self.amount_was : self.amount)
    z_food_item = (was ? self.food_item_was : self.food_item)

    return 0 unless z_food_item
    
    if z_unit == "Grammar::Vocabulary::Serving"
      z_amount *= z_food_item.serving_size
      z_unit = z_food_item.serving_size_unit
    end

    # Serving size may be specified in volumetric units.
    if z_unit == "Grammar::Vocabulary::Litre"
      z_amount *= (z_food_item.density/1000.0)
      z_unit = "Grammar::Vocabulary::Gram"
    end

    # Everything is measured in multiples of 100g.
    return z_amount / 100.0
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

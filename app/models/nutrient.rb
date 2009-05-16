class Nutrient < ActiveRecord::Base

  has_many :food_item_nutrients
  has_many :food_items, :through => :food_item_nutrients

end

class FoodItemNutrient < ActiveRecord::Base

  belongs_to :food_item
  belongs_to :nutrient

end

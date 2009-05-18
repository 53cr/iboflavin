class FoodItem < ActiveRecord::Base
  
  belongs_to :food_group

  has_many :food_item_nutrients
  has_many :nutrients, :through => :food_item_nutrients


  define_index do

    indexes name

  end

  
end

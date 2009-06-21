class Nutrient < ActiveRecord::Base

  has_many :food_item_nutrients
  has_many :food_items, :through => :food_item_nutrients

  def self.select_options
    nutrients = Nutrient.all
    nutrients.reject! {|n| !n.description.index(/^[a-zA-Z]/) }
    nutrients.map do |nutrient|
      [nutrient.description + " (#{nutrient.unit})", nutrient.id]
    end
  end
end

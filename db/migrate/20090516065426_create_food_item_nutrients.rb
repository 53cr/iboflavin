class CreateFoodItemNutrients < ActiveRecord::Migration
  def self.up
    create_table :food_item_nutrients do |t|
      t.integer :food_item_id
      t.integer :nutrient_id
      t.float  :amount
    end
  end

  def self.down
    drop_table :food_item_nutrients
  end
end

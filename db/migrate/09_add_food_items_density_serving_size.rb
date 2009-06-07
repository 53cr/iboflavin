class AddFoodItemsDensityServingSize < ActiveRecord::Migration
  def self.up
    add_column :food_items, :serving_size, :float
    add_column :food_items, :serving_size_unit, :string
    add_column :food_items, :density, :float
  end

  def self.down
    remove_column :food_items, :serving_size
    remove_column :food_items, :serving_size_unit
    remove_column :food_items, :density
  end
end

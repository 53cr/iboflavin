class AddIndices < ActiveRecord::Migration
  def self.up

    add_index :food_items, :name
    
  end

  def self.down

    remove_index :food_items, :name

  end
end

class AddIndices < ActiveRecord::Migration
  def self.up

  end

  def self.down

    remove_index :food_items, :name

  end
end

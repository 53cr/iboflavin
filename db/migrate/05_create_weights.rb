class CreateWeights < ActiveRecord::Migration
  def self.up
    create_table :weights do |t|
      t.integer :food_item_id
      t.float :amount
      t.string :description
      t.float :grams
    end
  end

  def self.down
    drop_table :weights
  end
end

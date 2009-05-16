class CreateFoodItems < ActiveRecord::Migration
  def self.up
    create_table :food_items do |t|
      t.integer :food_group_id
      t.string :long_desc
      t.string :short_desc
      t.string :common_names
      t.string :manufacturer_name
      t.string :scientific_name
    end
  end

  def self.down
    drop_table :food_items
  end
end

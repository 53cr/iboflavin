class CreateEntryMatches < ActiveRecord::Migration
  def self.up
    create_table :entry_matches do |t|

      t.integer :user_id
      t.integer :entry_id
      
      t.string :search
      t.string :sigsearch
      t.integer :food_item_id

      t.float :amount
      t.string :unit
      
      t.timestamps
    end
  end

  def self.down
    drop_table :entry_matches
  end
end

class CreateGoals < ActiveRecord::Migration
  def self.up
    create_table :goals do |t|
      t.integer :nutrient_id
      t.integer :user_id
      t.float :amount
      t.string :unit

      t.timestamps
    end
  end

  def self.down
    drop_table :goals
  end
end

class CreateNutrients < ActiveRecord::Migration
  def self.up
    create_table :nutrients do |t|
      t.string :unit
      t.string :tagname
      t.string :description
    end
  end

  def self.down
    drop_table :nutrients
  end
end

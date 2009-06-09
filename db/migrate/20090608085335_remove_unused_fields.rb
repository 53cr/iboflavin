class RemoveUnusedFields < ActiveRecord::Migration
  def self.up
    remove_column :food_items, :manufacturer_name
    remove_column :food_items, :common_names
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end

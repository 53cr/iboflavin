class DeleteWeights < ActiveRecord::Migration
  def self.up
    drop_table :weights
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end

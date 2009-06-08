class AddLifestyleToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :lifestyle, :string
  end

  def self.down
    remove_column :users, :lifestyle
  end
end

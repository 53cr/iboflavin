class AddUsersTimeZone < ActiveRecord::Migration
  def self.up
    add_column :users, :time_zone, :integer, :null => false, :default => -18000
  end

  def self.down
    remove_column :users, :time_zone
  end
end

class AddPregnantLactatingSexAndAgeToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :pregnant, :boolean, :default => false
    add_column :users, :lactating, :boolean, :default => false
    add_column :users, :sex, :string
    add_column :users, :birthday, :date
  end

  def self.down
    remove_column :users, :birthday
    remove_column :users, :sex
    remove_column :users, :lactating
    remove_column :users, :pregnant
  end
end

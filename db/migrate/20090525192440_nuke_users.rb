class NukeUsers < ActiveRecord::Migration
  def self.up

    drop_table :users
    drop_table :roles
    drop_table :user_roles

  end

  def self.down

    raise ActiveRecord::IrreversibleMigration
    
  end
end

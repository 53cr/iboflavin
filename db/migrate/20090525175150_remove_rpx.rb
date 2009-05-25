class RemoveRpx < ActiveRecord::Migration
  def self.up

    remove_column :users, :rpx_identifier
    remove_column :users, :provider_name
    remove_column :users, :twitter_account
    remove_column :users, :twitter_account_confirmed

  end

  def self.down

    raise ActiveRecord::IrreversibleMigration
    
  end
end

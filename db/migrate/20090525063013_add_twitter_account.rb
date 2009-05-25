class AddTwitterAccount < ActiveRecord::Migration
  def self.up

    add_column :users, :twitter_account, :string
    add_column :users, :twitter_account_confirmed, :integer

  end

  def self.down

    remove_column :users, :twitter_account
    remove_column :users, :twitter_account_confirmed

  end
end

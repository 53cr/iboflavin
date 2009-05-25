class AddUsersRpxIdentifier < ActiveRecord::Migration
  def self.up
    add_column :users, :rpx_identifier, :string
    add_column :users, :name, :string
    add_column :users, :provider_name, :string

    add_index :users, :rpx_identifier

    remove_column :users, :state

    change_column :users, :login, :string, :default => nil, :null => true
    change_column :users, :crypted_password, :string, :default => nil, :null => true
    change_column :users, :password_salt, :string, :default => nil, :null => true

  end

  def self.down
    remove_column :users, :rpx_identifier
    remove_column :users, :name
    remove_column :users, :provider_name

    add_column :users, :state, :string


    [:login, :crypted_password, :password_salt].each do |field|
      User.all(:conditions => "#{field} is NULL").each { |user| user.update_attribute(field, "") if user.send(field).nil? }
      change_column :users, field, :string, :default => "", :null => false
    end
  end
end

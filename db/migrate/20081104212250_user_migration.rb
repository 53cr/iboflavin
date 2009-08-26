class UserMigration < ActiveRecord::Migration
  def self.up
    create_table(:users) do |t|
      t.string    :username,            :null => false
      t.string    :email,               :null => false
      t.string    :crypted_password,    :null => false
      t.string    :password_salt,       :null => false
      t.string    :type
      t.string    :persistence_token,   :null => false
      t.string    :single_access_token, :null => false
      t.string    :perishable_token,    :null => false
      t.string    :state,               :null => false
      t.string    :phone
      t.string    :country
      t.boolean   :admin

      t.integer  :login_count,        :null => false, :default => 0 
      t.integer  :failed_login_count, :null => false, :default => 0 
      t.datetime :last_request_at 
      t.datetime :current_login_at
      t.datetime :last_login_at   
      t.string   :current_login_ip 
      t.string   :last_login_ip     
      t.text     :description

      t.string   :picture_file_name    
      t.string   :picture_content_type
      t.integer  :picture_file_size    
      t.datetime :picture_updated_at   
  
      t.timestamps
    end

    add_index :users, :id
    add_index :users, :email
  end

  def self.down
    drop_table :users
  end
end

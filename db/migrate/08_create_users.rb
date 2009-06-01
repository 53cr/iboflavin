class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string    :login, :default => nil, :null => true
      t.string    :email, :default => nil, :null => true
      t.string    :crypted_password
      t.string    :password_salt, :default => nil, :null => true
      t.string    :persistence_token, :null => false
      t.string    :single_access_token
      t.string    :perishable_token  

      t.integer   :login_count,         :null => false, :default => 0
      t.integer   :failed_login_count,  :null => false, :default => 0
      t.datetime  :last_request_at
      t.datetime  :current_login_at
      t.datetime  :last_login_at
      t.string    :current_login_ip
      t.string    :last_login_ip

      t.boolean   :pregnant,            :default => false
      t.boolean   :lactating,           :default => false
      t.string    :sex
      t.date      :birthday
      t.string    :twitter_screen_name
      t.string    :oauth_token
      t.string    :oauth_secret

      t.string    :timezone

      t.timestamps
    end
    add_index :users, :login
    add_index :users, :email
    add_index :users, :oauth_token
  end

  def self.down
    drop_table :users
  end
end

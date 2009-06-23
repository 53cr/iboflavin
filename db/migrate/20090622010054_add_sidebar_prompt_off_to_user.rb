class AddSidebarPromptOffToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :sidebar_prompt_off, :boolean, :default => false
  end

  def self.down
    remove_column :users, :sidebar_prompt_off
  end
end

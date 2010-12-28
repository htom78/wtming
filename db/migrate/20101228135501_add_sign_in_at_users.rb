class AddSignInAtUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :current_sign_in_ip,:string 
  end

  def self.down
    remove_column :users, :current_sign_in_ip
  end
end

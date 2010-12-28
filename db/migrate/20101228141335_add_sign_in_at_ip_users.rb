class AddSignInAtIpUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :last_sign_in_ip, :string
  end

  def self.down
    remove_column :users, :last_sign_in_ip
  end
end

class AddTokenToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :single_access_token, :string
    add_column :users, :persistence_token, :string
  end

  def self.down
    remove_column :users, :single_access_token
    remove_column :users, :persistence_token
  end
end

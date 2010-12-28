class AddSignCountUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :sign_in_count, :integer
  end

  def self.down
    remove_column :users, :sign_in_count
  end
end

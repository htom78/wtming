class AddPicToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :pic_file_name, :string
    add_column :posts, :pic_content_type, :string
    add_column :posts, :pic_file_size, :integer
    add_column :posts, :pic_updated_at, :datetime
    add_column :posts, :implemented, :boolean, :default => false, :null => false
  end

  def self.down
    remove_column :posts, :implemented
    remove_column :posts, :pic_updated_at
    remove_column :posts, :pic_file_size
    remove_column :posts, :pic_content_type
    remove_column :posts, :pic_file_name
  end
end

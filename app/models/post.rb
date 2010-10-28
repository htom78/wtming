class Post < ActiveRecord::Base
  attr_accessible :pic, :title, :description, :implemented
  has_attached_file :pic, :styles => { :large => "300x300>", :thumb => "24x24>" },
    :url  => "/uploads/:id/:style/:basename.:extension",
    :path => ":rails_root/public/uploads/:id/:style/:basename.:extension"

  belongs_to :user
  acts_as_taggable_on :tags

end

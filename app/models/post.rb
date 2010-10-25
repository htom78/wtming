class Post < ActiveRecord::Base
  attr_accessible :pic
#  has_attached_file :pic

  acts_as_taggable_on :tags

end

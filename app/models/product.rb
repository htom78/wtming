class Product < ActiveRecord::Base
  attr_accessible :pic
  has_attached_file :pic
end

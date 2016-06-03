class Student < ActiveRecord::Base
  belongs_to :table
  has_many :tablemates
  has_many :neighbors, through: :tablemates
  
end

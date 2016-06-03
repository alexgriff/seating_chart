class Tablemate < ActiveRecord::Base
  belongs_to :student
  belongs_to :neighbor, class_name: "Student"

end

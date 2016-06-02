class Table < ActiveRecord::Base
  has_many :students

  def has_available_seat?
    seats > students.length
  end

end

class Student < ActiveRecord::Base
  belongs_to :table
  has_many :table_neighbors
  has_many :neighbors, through: :table_neighbors

  def assign_table(table)
    if table.has_available_seat?
      add_neighbors(table.students)
      table.students << self
    else
      raise Exception.new("The table has no available seats")
    end
  end

  private

  def add_neighbors(other_students)
    other_students.each do |student|
      self.table_neighbors.create(neighbor: student)
      student.table_neighbors.create(neighbor: self)
    end
  end


end

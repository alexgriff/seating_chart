class Shuffler

  attr_reader :students

  def initialize(students)
    @students = students.shuffle
  end

  def next(num_students = 1)
    students.pop(num_students)
  end

end

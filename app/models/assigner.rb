class Assigner

  def fill_table(table, shuffler)
    students = shuffler.next(table.seats)
    students.each do |student|
      assign(student, table)
    end
  end

  def assign(student, table)
    if table.has_available_seat?
      create_tablemates(student, table.students) if table.students.present?
      table.students << student
    else
      raise Exception.new("The table has no available seats")
    end
  end

  private

  def create_tablemates(student, other_students)
    other_students.each do |other_student|
      Tablemate.create(student: student, neighbor: other_student)
      Tablemate.create(student: other_student, neighbor: student)
    end
  end

end

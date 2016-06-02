require 'rails_helper'

RSpec.describe Student, type: :model do

  describe '#add_neighbors' do
    let(:student1) { Student.create(name: "abc") }
    let(:student2) { Student.create(name: "def") }

    it 'builds a connection in both directions between students' do
      student1.send(:add_neighbors, [student2])
      expect(student1.neighbors).to include student2
      expect(student2.neighbors).to include student1
    end
  end

  describe '#assign_table' do
    let(:table) { Table.create(number: 1, seats: 1) }
    let(:student) { Student.create(name: "Stew Dent") }

    before do
      student.assign_table(table)
    end

    it 'assigns a student a table if there is room' do
      expect(table.students).to include(student)
    end

    it 'raises an exception if there is no space at the table' do
      other_student = Student.create(name: "Other Student")
      expect{other_student.assign_table(table)}.to raise_exception("The table has no available seats")
    end

  end


  context 'when each new student is assigned to a table it will add all the students already there to student\'s list of neighbors' do

    let(:table) { Table.create(number: 1, seats: 4) }
    let(:student1) { Student.create(name: "abc") }
    let(:student2) { Student.create(name: "def") }
    let(:student3) { Student.create(name: "ghi") }

    it 'the first student assigned to a table has no neighbors' do
      student1.assign_table(table)
      expect(student1.neighbors).to be_empty
    end

    it 'the second student has one neighbor who is the first student' do
      student1.assign_table(table)
      student2.assign_table(table)
      expect(student2.neighbors.size).to eq 1
      expect(student2.neighbors.first.id).to eq student1.id
    end

    it 'the first student now has the second student as a neighbor' do
      student1.assign_table(table)
      student2.assign_table(table)
      expect(student1.neighbors).to include student2
    end
  end
end

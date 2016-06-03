require 'rails_helper'

RSpec.describe Assigner do

  describe '#assign' do
    context 'assigns students to tables with available seats' do
      let(:table) { Table.create(number: 1, seats: 1) }
      let(:student) { Student.create(name: "Stew Dent") }
      let(:assigner) { Assigner.new }

      before do
        assigner.assign(student, table)
      end

      it 'assigns a student a table if there is room' do
        expect(table.students).to include(student)
      end

      it 'raises an exception if there is no space at the table' do
        other_student = Student.create(name: "Other Student")

        expect{assigner.assign(other_student, table)}.to raise_exception("The table has no available seats")
      end
    end
  end

  describe '#assign' do
    context 'when each new student is assigned to a table it will add all the students already there to student\'s list of neighbors' do
      let(:table) { Table.create(number: 1, seats: 4) }
      let(:student1) { Student.create(name: "abc") }
      let(:student2) { Student.create(name: "def") }
      let(:student3) { Student.create(name: "ghi") }
      let(:assigner) { Assigner.new }

      it 'adds no neighbors to the first student assigned to a table' do
        assigner.assign(student1, table)

        expect(student1.neighbors).to be_empty
      end

      it 'adds the first student as a neighbor of the second assigned student' do
        assigner.assign(student1, table)
        assigner.assign(student2, table)

        expect(student2.neighbors.size).to eq 1
        expect(student2.neighbors).to include student1
      end

      it 'adds the second student as a neighbor of the first' do
        assigner.assign(student1, table)
        assigner.assign(student2, table)

        expect(student1.neighbors.size).to eq 1
        expect(student1.neighbors).to include student2
      end

      it 'gives two neigbors to the third student' do
        assigner.assign(student1, table)
        assigner.assign(student2, table)
        assigner.assign(student3, table)

        expect(student3.neighbors.size).to eq 2
        expect(student3.neighbors).to include student1
        expect(student3.neighbors).to include student2
      end

      it 'gives any student at a table-of-three two neigbors' do
        assigner.assign(student1, table)
        assigner.assign(student2, table)
        assigner.assign(student3, table)

        expect(student1.neighbors.size).to eq 2
        expect(student2.neighbors.size).to eq 2
      end
    end
  end

  describe '#fill_table' do
    let(:table) { Table.create(number: 1, seats: 3) }
    let(:student1) { Student.create(name: "abc") }
    let(:student2) { Student.create(name: "def") }
    let(:student3) { Student.create(name: "ghi") }
    let(:assigner) { Assigner.new }

    it 'should assign a student to every seat at the table' do
      assigner.fill_table(table)

      expect(table.full).to be true
    end
  end
end

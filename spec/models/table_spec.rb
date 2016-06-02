require 'rails_helper'

RSpec.describe Table, type: :model do
  describe '#has_available_seat?' do
      let(:table) { Table.create(number: 1, seats: 3) }
      let(:student1) { Student.create(name: 'Xyz')}
      let(:student2) { Student.create(name: 'Abc')}
      let(:student3) { Student.create(name: 'Def')}

    before do
      student1.assign_table(table)
      student2.assign_table(table)
    end

    it 'returns true if a table has less students than seats' do
      expect(table.has_available_seat?).to be true
    end

    it 'returns false if a table is full' do
      student3.assign_table(table)
      expect(table.has_available_seat?).to be false
    end
  end
end

class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.belongs_to :table, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end

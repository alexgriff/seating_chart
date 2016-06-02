class CreateTableNeighbors < ActiveRecord::Migration
  def change
    create_table :table_neighbors do |t|
      t.belongs_to :student, index: true, foreign_key: true
      t.integer :neighbor_id

      t.timestamps null: false
    end
  end
end

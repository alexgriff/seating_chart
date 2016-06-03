class RenameTableNeighborsToTablemates < ActiveRecord::Migration
  def change
    rename_table :table_neighbors, :tablemates
  end
end

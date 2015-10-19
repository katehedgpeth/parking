class AddResultsColumnToPoints < ActiveRecord::Migration
  def up
    add_column :points, :geo_results, :text
  end
  def down
    remove_column :points, :geo_results
  end
end

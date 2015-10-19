class RevertIssueDateColumnType < ActiveRecord::Migration
  def up
    change_column :points, :issue_date, :string
  end

  def down
    change_column :points, :issue_date, :datetime
  end
end

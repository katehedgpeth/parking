class ChangePointColumnTypes < ActiveRecord::Migration
  def up
    change_column :points, :badge_numb, :string
    change_column :points, :issue_date, :datetime
  end

  def down
    change_column :points, :badge_numb, :integer
    change_column :points, :issue_date, :string
  end 
end

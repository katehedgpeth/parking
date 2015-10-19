class RemoveContentColumn < ActiveRecord::Migration
  def up
    remove_column :points, :content
  end
  def down
    add_column :points, :content, :text
  end
end

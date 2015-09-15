class ChangeSomeFields < ActiveRecord::Migration
  def change
    change_column :books, :description, :text
    change_column :books, :page_count, :integer, null: false, default: 0
  end
end

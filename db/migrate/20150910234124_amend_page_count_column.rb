class AmendPageCountColumn < ActiveRecord::Migration
  def change
    change_column :books, :page_count, :integer, null: true, default: 0
  end
end

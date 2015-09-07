class AddBookPageCountAuthors < ActiveRecord::Migration
  
  def change
    add_column :books, :authors, :string
    add_column :books, :description, :string
    add_column :books, :page_count, :integer
    add_column :books, :categories, :string
    add_column :books, :publisher, :string
    add_column :books, :published_date, :date
  end
end

class CreateBooksTags < ActiveRecord::Migration
  def change
    create_table :books_tags do |t|
      t.integer :book_id
      t.integer :user_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end

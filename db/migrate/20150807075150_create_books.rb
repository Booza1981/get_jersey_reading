class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :link
      t.text :isbn

      t.timestamps null: false
    end
  end
end

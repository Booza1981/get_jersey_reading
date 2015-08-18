class AddTitleAndImageLinkToBooks < ActiveRecord::Migration
  def change
    add_column :books, :title, :string
    add_column :books, :image_link, :string
  end
end

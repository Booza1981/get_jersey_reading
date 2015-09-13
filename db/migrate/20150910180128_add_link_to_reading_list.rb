class AddLinkToReadingList < ActiveRecord::Migration
  def change
    add_column :reading_lists, :image_link, :string
  end
end

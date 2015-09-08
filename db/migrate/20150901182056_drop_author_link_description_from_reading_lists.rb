class DropAuthorLinkDescriptionFromReadingLists < ActiveRecord::Migration
  def change
  	remove_column :reading_lists, :author
  	remove_column :reading_lists, :link
  	remove_column :reading_lists, :description
  end
end

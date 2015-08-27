class CreateReadingListBooksGenreJoin < ActiveRecord::Migration
  def self.up
    create_table 'book_reading_lists' do |t|
      t.integer :reading_list_id
      t.integer :book_id
    end
  end

  def self.down
  	drop_table 'book_reading_lists'
  end
end

class ReadingList < ActiveRecord::Base
  has_many :book_reading_lists
  has_many :books, :through => :book_reading_lists
end

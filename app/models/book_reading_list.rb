class BookReadingList < ActiveRecord::Base
	belongs_to :book 
	belongs_to :reading_list
end

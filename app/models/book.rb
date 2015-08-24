class Book < ActiveRecord::Base
	has_many :reviews
	# Automatically add google book info when a book is created
	after_create :add_information_from_google_books

	# Loops over all the books and adds title and image link to the database (uses the Google Book API)
	# Run this by going to the console and typing
	# $ Book.add_all_books_info
	def self.add_all_books_info

		Book.all.each do |book|
			book.add_information_from_google_books
		end
		
	end


	def add_information_from_google_books
		if title.blank? && image_link.blank?

		    google_book = GoogleBooks.search(isbn, { api_key: 'AIzaSyBOnVO64hRZ-18i0pqXBIQ-2BT7iK9_5qc'} )
		    self.update_columns(title: google_book.first.title, image_link: google_book.first.image_link)

	  	end
	end

end

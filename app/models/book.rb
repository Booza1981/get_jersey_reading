class Book < ActiveRecord::Base
	validates :link, uniqueness: true
	has_many :reviews
	
	has_many :book_reading_lists
	has_many :reading_lists, :through => :book_reading_lists

	# Automatically add google book info when a book is created
	after_create :add_information_from_google_books, :modify_page_count_if_null
	after_update :add_information_from_google_books, :modify_page_count_if_null

	has_many :books_tags, dependent: :destroy
	has_many :tags, through: :books_tags
	has_many :users, through: :books_tags


	BOOKS = [
		{ isbn: '0141355743', link: "http://capitadiscovery.co.uk/jersey/items/365975?query=Steven+Butler&resultsUri=items%3Fquery%3DSteven%2BButler" },
		{ isbn: '0141333901', link: "http://capitadiscovery.co.uk/jersey/items/365975?query=Steven+Butler&resultsUri=items%3Fquery%3DSteven%2BButler" },

	]


	# Loops over all the books and adds title and image link to the database (uses the Google Book API)
	# Run this by going to the console and typing
	# $ Book.add_all_books_info
	def self.add_all_books_info

		Book.all.each do |book|
			book.add_information_from_google_books
		end
		
	end


	def add_information_from_google_books

		if isbn.present?

	    google_books = GoogleBooks.search(isbn, { api_key: 'AIzaSyBOnVO64hRZ-18i0pqXBIQ-2BT7iK9_5qc'} )

	    if google_books.any?

	    	book = google_books.first

		    self.update_columns(	title: book.title, 
		    											image_link: book.image_link,
		    											page_count: book.page_count,
		    											authors: book.authors,
		    											description: book.description,
		    											categories: book.categories,
		    										)
		  end

	  end

	end

	def modify_page_count_if_null

		if page_count == "null"
			page_count = 0
		end
	end
end

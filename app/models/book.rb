class Book < ActiveRecord::Base

	def self.add_information_from_google_books

		Book.all.each do |book|

			if book.title.blank? && book.image_link.blank?

		    google_book = GoogleBooks.search(book.isbn, { api_key: 'AIzaSyBOnVO64hRZ-18i0pqXBIQ-2BT7iK9_5qc'} )
		    book.update_columns(title: google_book.first.title, image_link: google_book.first.image_link)

		  end
	    
		end
		
	end

end

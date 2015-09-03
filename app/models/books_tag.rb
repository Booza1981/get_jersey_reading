class BooksTag < ActiveRecord::Base
	belongs_to :book
	belongs_to :tag
	belongs_to :user
end

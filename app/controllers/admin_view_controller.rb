class AdminViewController < ApplicationController
	def index
		@books = Book.all

		@tags = Tag.all
	end


end

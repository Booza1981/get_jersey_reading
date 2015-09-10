class AdminViewController < ApplicationController
	def admin_view
		@books = Book.all
		@tags = Tag.all
		@users = User.all
	end
end

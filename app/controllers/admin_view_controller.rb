class AdminViewController < ApplicationController
	def admin_view
		@books_grid = initialize_grid(Book.all, name: 'g1', order:'books.created_at', order_direction: 'desc')
		@tags_grid = initialize_grid(Tag.all, name: 'g2')
		@users_grid = initialize_grid(User.all, name: 'g3', order:'users.created_at', order_direction: 'desc')
		@reading_lists_grid = initialize_grid(ReadingList.all, name: 'g4', order:'reading_lists.created_at', order_direction: 'desc')
	end


end

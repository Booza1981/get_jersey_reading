class ProfilesController < ApplicationController
  
  def show
  	if params[:id].present?
  		@user = User.find_by_username(params[:id])
  	else
  		@user = current_user
  	end
    @recommended_books = @user.recommended_books

    @liked_books = @user.liked_books
    @disliked_books = @user.disliked_books
    @hidden_books = @user.hidden_books

    @read_books = @liked_books + @disliked_books + @hidden_books
  end

end

class ProfilesController < ApplicationController
  
  def show
  	if params[:id].present?
  		@user = User.find_by_username(params[:id])
  	else
  		@user = current_user
  	end
  	
  	Recommendable::Helpers::Calculations.update_similarities_for(@user.id)
    Recommendable::Helpers::Calculations.update_recommendations_for(@user.id)

    @recommended_books = @user.recommended_books

    liked_books = @user.liked_books
    disliked_books = @user.disliked_books
    hidden_books = @user.hidden_books

    @read_books = liked_books + disliked_books + hidden_books
  end

  def destroy
    user.destroy

    if user.destroy
        redirect_to root_url, notice: "User deleted."
    end
  end

end

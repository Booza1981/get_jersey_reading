class ProfilesController < ApplicationController
  
  def show
  	if params[:id].present?
  		@user = User.find_by_username(params[:id])
  	else
  		@user = current_user
  	end
    @books = Book.all
  end

end

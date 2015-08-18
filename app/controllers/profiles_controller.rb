class ProfilesController < ApplicationController
  
  def show
  	@user = current_user
    @books = Book.all
  end

  def friend
  	@user = User.find_by_username(params[:id])
  end

end

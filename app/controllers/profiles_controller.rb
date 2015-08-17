class ProfilesController < ApplicationController
  def show
  	@user = User.find_by_username(params[:id])
    if @user
      @books = @user.books.all
    else
  	  render action: :show
  	end
  end
end

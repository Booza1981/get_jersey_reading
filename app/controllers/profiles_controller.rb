class ProfilesController < ApplicationController
  def show
  	@user = User.find_by_username(params[:id]) || current_user
    if @user
      @books = @user.books.all
    else
  	  render action: :show
  	end
  end
end

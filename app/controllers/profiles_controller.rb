class ProfilesController < ApplicationController
  def show
  	@user = User.find_by_username(params[:id])
    if @user
      @books = @user.books.all
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  	render action: :show
  end
end

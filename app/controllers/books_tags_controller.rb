class BooksTagsController < ApplicationController
  	
  def create
  	@books_tag = BooksTag.new(books_tag_params)
  	@books_tag.user = current_user
  	@books_tag.save
  end

  def destroy
  	@books_tag = BooksTag.find(params[:id])
  	@books_tag.destroy
  end




  private 

	# Never trust parameters from the scary internet, only allow the white list through.
	def books_tag_params
	  params.require(:books_tag).permit(:book_id, :tag_id)
	end

end

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :like, :dislike, :hide]
  
  # GET /books
  # GET /books.json
  def index
    @top_readers = User.limit(3)
    @top_recommended_books = Book.top(5)
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book_link = @book.link
    @books = GoogleBooks.search(@book.isbn) # yields a collection of one result
    @book_show = @books.first # the one result
    @thumb = @book_show.image_link(:zoom => 4)
    top_tags
  end

  def top_tags
    @top_tags = Tag.joins(:books).where(:books => {:id => @book.id}).group(:name).count.sort_by{|k,v| v}.reverse.first(3).map {|a| a[0]}
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)
      if @book.save
        redirect_to @book
      else
        render :new
      end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    if @book.update(book_params)
      redirect_to @book
    else
      render :edit
    end
  end

  def tags

  end


  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /books/:id/like
  def like
    current_user.unhide(@book)
    current_user.like(@book)
    redirect_to @book, notice: 'Thanks for voting!'
  end

  # POST /books/:id/dislike
  def dislike
    current_user.unhide(@book)
    current_user.dislike(@book)
    redirect_to @book, notice: 'Thanks for voting!'
  end

  # POST /books/:id/hide
  def hide
    current_user.unlike(@book)
    current_user.undislike(@book)
    current_user.hide(@book)
    redirect_to @book, notice: 'Thanks for voting!'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:link, :isbn, :image_link, :title, :description, :user_id, tag_ids: [])
    end
end

class BooksController < ApplicationController

  before_action :set_book, only: [:show, :edit, :update, :destroy, :like, :dislike, :hide]
  
  # GET /books
  # GET /books.json
  def index
    
    @books = Book.all
    @top_readers = User.all.sort_by(&:points).reverse.take(3)
    @top_recommended_books = Book.top(5)
  end

  # GET /books/1
  # GET /books/1.json
  def show
    authorize! :read, Book
    @book_link = @book.link
    @books = GoogleBooks.search(@book.isbn) # yields a collection of one result
    @book_show = @books.first # the one result
    @thumb = @book_show.image_link(:zoom => 4)
  end

  def top_tags
    @top_tags = Tag.joins(:books).where(:books => {:id => @book.id}).group(:name).count.sort_by{|k,v| v}.reverse.first(3).map {|a| a[0]}
  end

  # GET /books/new
  def new
    authorize! :create, Book
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    authorize! :update, @book

  end

  # POST /books
  # POST /books.json
  def create
    authorize! :create, Book
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
    authorize! :update, @book

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
  end

  # POST /books/:id/dislike
  def dislike
    current_user.unhide(@book)
    current_user.dislike(@book)
  end

  # POST /books/:id/hide
  def hide
    current_user.unlike(@book)
    current_user.undislike(@book)
    current_user.hide(@book)
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

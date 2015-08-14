class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /books
  # GET /books.json
  def index
    @books = Book.all

    @top_rated_isbn = []



    @books.each do |book|
      @top_rated_isbn.push(book.isbn)
    end

    @book_title = []
    @book_thumb = []

    @top_rated_isbn.each do |top_isbn|
      @book = GoogleBooks.search(top_isbn, { api_key: 'AIzaSyBOnVO64hRZ-18i0pqXBIQ-2BT7iK9_5qc'} )
      @book_title.push(@book.first.title)
      @book_thumb.push(@book.first.image_link)
    end

    @top_reader_avatar = ["http://img1.wikia.nocookie.net/__cb20150105230449/pokemon/images/1/13/007Squirtle_Pokemon_Mystery_Dungeon_Explorers_of_Sky.png", "http://images2.fanpop.com/image/photos/11600000/Pikachu-the-ultimate-pokemon-fan-club-11690553-450-413.jpg", "http://img3.wikia.nocookie.net/__cb20140903033758/pokemon/images/b/b8/001Bulbasaur_Dream.png"]
    @top_reader_username = ["Squirtle", "Pikachu", "Bulbasaur"]
    @top_reader_points = [186, 123, 96]
  end



  # GET /books/1
  # GET /books/1.json
  def show
    @book_link = @book.link
    @books = GoogleBooks.search(@book.isbn) # yields a collection of one result
    @book_show = @books.first # the one result
    @thumb = @book_show.image_link(:zoom => 4)
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
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book}
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:link, :isbn, :image_link, :title, :description)
    end
end

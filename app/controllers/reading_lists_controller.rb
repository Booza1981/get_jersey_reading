class ReadingListsController < ApplicationController
  before_action :set_reading_list, only: [:show, :edit, :update, :destroy]

  # GET /reading_lists
  # GET /reading_lists.json
  def index
    @reading_lists = ReadingList.all
  end

  # GET /reading_lists/1
  # GET /reading_lists/1.json
  def show
  end

  # GET /reading_lists/new
  def new
    @reading_list = ReadingList.new
  end

  # GET /reading_lists/1/edit
  def edit
  end

  # POST /reading_lists
  # POST /reading_lists.json
  def create
    @reading_list = ReadingList.new(reading_list_params)

    respond_to do |format|
      if @reading_list.save
        format.html { redirect_to admin_path, notice: 'Reading list was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /reading_lists/1
  # PATCH/PUT /reading_lists/1.json
  def update
    respond_to do |format|
      if @reading_list.update(reading_list_params)
        format.html { redirect_to admin_path, notice: 'Reading list was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /reading_lists/1
  # DELETE /reading_lists/1.json
  def destroy
    @reading_list.destroy
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'Reading list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reading_list
      @reading_list = ReadingList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reading_list_params
      params.require(:reading_list).permit(:title)
    end
end

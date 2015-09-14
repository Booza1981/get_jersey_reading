class UsersController < ApplicationController
  before_action :set_user

  def edit
  end


  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to admin_path, notice: 'Tag was successfully updated.'}
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_path, notice: 'Tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def admin
  	if @user.admin == true
  		@user.admin = false
  		@user.save
  		respond_to do |format|
      		format.html { redirect_to admin_path }
    	end
  	else
  		@user.admin = true
  		@user.save
  		respond_to do |format|
      		format.html { redirect_to admin_path }
    	end
  	end 	
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:user).permit(:id)
    end

end

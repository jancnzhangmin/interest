class InterestversionsController < ApplicationController

  before_action :set_interestversion, only: [:show, :edit, :update, :destroy]
  def index
    @interestversions = Interestversion.all
  end

  def edit
    @interestversion = Interestversion.find(params[:id])
  end

  def new
    @interestversion = Interestversion.new
  end

  def create
    @interestversion = Interestversion.new(interestversion_params)
    respond_to do |format|
      if @interestversion.save
        format.html { redirect_to interestversions_path, notice: 'Interestversion was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @interestversion.update(interestversion_params)
        format.html { redirect_to interestversions_path, notice: 'Interestversion was successfully updated.' }
        format.json { render :show, status: :ok, location: @interestversion }
      else
        format.html { render :edit }
        format.json { render json: @interestversion.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @interestversion.destroy
    respond_to do |format|
      format.html { redirect_to interestversions_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_interestversion
    @interestversion = Interestversion.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def interestversion_params
    params.require(:interestversion).permit(:name ,:rate)
  end

end

class DeposittypedefsController < ApplicationController

  before_action :set_deposittypedef, only: [:show, :edit, :update, :destroy]
  def index
    @deposittypedefs = Deposittypedef.all

  end

  def edit

  end

  def new
    @deposittypedef = Deposittypedef.new
  end

  def create
    @deposittypedef = Deposittypedef.new(deposittypedef_params)
    respond_to do |format|
      if @deposittypedef.save
        format.html { redirect_to deposittypedefs_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @deposittypedef.update(deposittypedef_params)
        format.html { redirect_to deposittypedefs_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @deposittypedef.destroy
    respond_to do |format|
      format.html { redirect_to deposittypedefs_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_deposittypedef
    @deposittypedef = Deposittypedef.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def deposittypedef_params
    params.require(:deposittypedef).permit(:depostitype)
  end

end

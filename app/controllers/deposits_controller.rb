class DepositsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @deposits = @user.deposits
  end

  def new
    @user = User.find(params[:user_id])
  @deposittypedefs = Deposittypedef.all

  end

  def create
    @user = User.find(params[:user_id])
    @deposit = @user.deposits.create(deposit_params)
    @user.capital=@user.capital + deposit_params[:amount].to_f
    @user.save
    redirect_to user_path(@user)
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.
  def deposit_params
    params.require(:deposit).permit(:deposittypedef_id ,:ordernumber,:amount, :red, :redid, :content)
  end

end

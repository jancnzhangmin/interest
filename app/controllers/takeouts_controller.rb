class TakeoutsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @takeouts = @user.takeouts
  end

  def new
    @user = User.find(params[:user_id])
    @cards = @user.cards
    @capital = @user.capital
  end

  def create
    @user = User.find(params[:user_id])
    @takeout = @user.takeouts.create!(takeout_params)
    @user.capital=@user.capital - takeout_params[:amount].to_f
    @user.save
    redirect_to user_path(@user)
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.
  def takeout_params
    params.require(:takeout).permit(:ordernumber,:amount, :red, :redid, :content, :card_id)
  end
end

class TakeoutsController < ApplicationController
  before_action {authen "takeout"}
  def index
    @user = User.find(params[:user_id])
    @takeouts = @user.takeouts.order('ordernumber desc')
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
    Flog.create(log:'新增取款 '+@user.username+':￥'+takeout_params[:amount],logtype:1,user:session[:username])
    redirect_to user_path(@user)
  end

  def redto
    @user = User.find(params[:user_id])
    takeout = Takeout.find(params[:id])
    if takeout.red.to_s == ''
      @user.capital += takeout.amount
      Flog.create(log:'红冲取款 '+@user.username+':￥'+takeout.amount.to_s,logtype:1,user:session[:username])
      Takeout.create(user_id:takeout.user_id,ordernumber:takeout.ordernumber,amount:-takeout.amount,red:1,redid:takeout.id,card_id:0)
    else
      Flog.create(log:'反冲取款 '+@user.username+':￥'+takeout.amount.to_s,logtype:1,user:session[:username])
      @user.capital += takeout.amount
      takeout.destroy
    end
    @user.save
    redirect_to user_takeouts_path(@user)
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.
  def takeout_params
    params.require(:takeout).permit(:ordernumber,:amount, :red, :redid, :content, :card_id)
  end
end

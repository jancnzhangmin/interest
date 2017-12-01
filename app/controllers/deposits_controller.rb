class DepositsController < ApplicationController
  before_action {authen "deposit"}
  def index
    @user = User.find(params[:user_id])
    @deposits = @user.deposits.order('ordernumber desc')
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
    Flog.create(log:'新增存款 '+@user.username+':￥'+@deposit.amount.to_s,logtype:1,user:session[:username])
    redirect_to user_path(@user)
  end

  def redto
    @user = User.find(params[:user_id])
    deposit = Deposit.find(params[:id])
    if deposit.red.to_s == ''
      @user.capital -= deposit.amount
      Deposit.create(deposittypedef_id:deposit.deposittypedef_id,user_id:deposit.user_id,ordernumber:deposit.ordernumber,amount:-deposit.amount,red:1,redid:deposit.id)
      Flog.create(log:'红冲存款 '+ @user.username + ' 单号：' + deposit.ordernumber + ' ￥' + deposit.amount.to_s,logtype:1,user:session[:username])
    else
      @user.capital -= deposit.amount
      Flog.create(log:'反冲存款 '+@user.username+' 单号：'+deposit.ordernumber+ ' ￥'+deposit.amount.to_s,logtype:1,user:session[:username])
      deposit.destroy
    end
    @user.save
    redirect_to user_deposits_path(@user)
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  # Never trust parameters from the scary internet, only allow the white list through.
  def deposit_params
    params.require(:deposit).permit(:deposittypedef_id ,:ordernumber,:amount, :red, :redid, :content)
  end

end

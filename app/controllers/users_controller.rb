class UsersController < ApplicationController
  before_action {authen "user"}
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 20).order("id desc")
    if params[:search]
      @users = User.where('username like ? or tel like ?',"%#{params[:search]}%","%#{params[:search]}%").paginate(:page => params[:page], :per_page => 20).order("id desc")
    end
    @userarr=Array.new
    @users.each do |f|
      usercla = Userclass.new
      usercla.id = f.id
      usercla.region_id=f.region_id
      usercla.interestversion = f.interestversion.name
      usercla.username=f.username
      if f.sex == 0
        usercla.sex = '男'
      else
        usercla.sex='女'
      end
      usercla.address=getregiont('',f.region_id)+f.address
      usercla.tel=f.tel
      usercla.content=f.content
      usercla.capital=f.capital
      @userarr.push(usercla)
    end
  end

  class Userclass
    attr :id,true
    attr :region_id,true
    attr :interestversion,true
    attr :username,true
    attr :sex,true
    attr :address,true
    attr :tel,true
    attr :content,true
    attr :capital,true
  end

  def edit
    @user = User.find(params[:id])
    @regions = Region.where('up_id =? or up_id is null','0')
    @interestversions = Interestversion.all
  end

  def new
    @user = User.new
    @regions = Region.where('up_id =? or up_id is null','0')
    @interestversions = Interestversion.all
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        Flog.create(log:'新增用户 '+@user.username,logtype:1,user:session[:username])
        if @user.capital.to_s ==''
          @user.capital = 0
          @user.save
        end
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        Flog.create(log:'编辑用户 '+@user.username,logtype:1,user:session[:username])
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Flog.create(log:'删除用户 '+@user.username,logtype:1,user:session[:username])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  def show
    @depositcount = @user.deposits.where('redid is null or redid = 0').count
    red=@user.deposits.where('redid > 0').count
    @depositcount=@depositcount-red
    @cardcount = @user.cards.count
    @srelationcount = @user.srelations.count
    @takeoutcount = @user.takeouts.where('redid is null or redid = 0').count
    takered =@user.takeouts.where('redid > 0').count
    @takeoutcount-=takered
    @interestcount = @user.finterests.count

    @userprocessarr = Array.new
    deposits = @user.deposits
    deposits.each do |deposit|
      userprocesscla = Userprocessclass.new
      userprocesscla.processtype='存入'
      userprocesscla.amount = sprintf("%.2f",deposit.amount)
      userprocesscla.time = deposit.created_at.strftime('%Y-%m-%d %H:%M:%S')
      @userprocessarr.push userprocesscla
    end
    takeouts = @user.takeouts
    takeouts.each do |takeout|
      userprocesscla = Userprocessclass.new
      userprocesscla.processtype='取出'
      userprocesscla.amount = sprintf("%.2f",takeout.amount)
      userprocesscla.time = takeout.created_at.strftime('%Y-%m-%d %H:%M:%S')
      @userprocessarr.push userprocesscla
    end
    interests = @user.finterests
    interests.each do |interest|
      userprocesscla = Userprocessclass.new
      userprocesscla.processtype='结息'
      userprocesscla.amount = sprintf("%.2f",interest.amount)
      userprocesscla.time = interest.created_at.strftime('%Y-%m-%d %H:%M:%S')
      @userprocessarr.push userprocesscla
    end
    #debugger
    @userprocessarr.sort_by! do |p|
      p.time
    end
    @userprocessarr.reverse!

    #@userprocessarr.paginate(:page => params[:page], :per_page => 20)

  end

  class Userprocessclass
    attr :processtype,true
    attr :amount,true
    attr :time,true
  end

  def getregion
    region = Region.find(params[:selfid]).childrens
    render json: region.to_json
  end

  def getregionparent
    region = Region.find(params[:selfid]).parent
    render json: region.to_json
  end

  def in

  end

  def getregionall
    regionstr = getregiont('',params[:regionid]) + User.find(params[:userid]).address
    render json: regionstr.to_json
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:region_id ,:interestversion_id,:username, :sex, :address, :tel, :content, :capital)
  end

  def getregiont(regionstr,id)
    region = Region.find(id)
    if region
      regionstr=region.region+regionstr
      if region.parent
        getregiont(regionstr,region.parent.id)
      else
        return regionstr
      end
    else
      return ''
    end
  end

end

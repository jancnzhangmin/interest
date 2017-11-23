class AdminsController < ApplicationController

  before_action :set_admin, only: [:show, :edit, :update, :destroy]
  def index
    @admins=Admin.all
  end

  def edit
    @admin=Admin.find(params[:id])
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(admin_params)
    respond_to do |format|
      if @admin.save
        Flog.create(log:'创建管理员'+@admin.username,logtype:1,user:session[:username])
        format.html { redirect_to admins_path, notice: 'Admin was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @admin.update(admin_params)
        Flog.create(log:'修改管理员'+@admin.username,logtype:1,user:session[:username])
        format.html { redirect_to admins_path, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @admin.destroy
    respond_to do |format|
      Flog.create(log:'删除管理员'+@admin.username,logtype:1,user:session[:username])
      format.html { redirect_to admins_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  def checklogin
    status = 'true'
    admin = Admin.find_by_login(params[:admin][:login])
    if admin
      status = 'false'
    else
      status = 'true'
    end
    #render json: '{"status":'+status+'}'
    render json: status
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @admin = Admin.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def admin_params
    params.require(:admin).permit(:username ,:login,:password, :password_confirmation, :auth, :status)
  end

end

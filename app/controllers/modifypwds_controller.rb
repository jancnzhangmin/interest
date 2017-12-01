class ModifypwdsController < ApplicationController

  def index
    @admin = Admin.find(session[:id])
  end

  def create
    admin = Admin.find_by(login:params[:modifypwd][:login])
    if admin && admin.authenticate(params[:modifypwd][:oldpassword])
      admin.password=params[:modifypwd][:password]
      admin.password_confirmation=params[:modifypwd][:password]
      admin.save
      Flog.create(log:'修改密码成功 '+admin.username,logtype:1,user:session[:username])
      flash[:success] = "密码修改成功！"
    else
      flash[:danger] = "旧密码错误！"

    end
    redirect_to modifypwds_path
  end

end

class LoginsController < ApplicationController



    def index
      if params[:command]
        session[:login]= nil
        session[:username] = nil
        session[:id]=nil
      end
    end

    def create

      checkadmin=Admin.all
      if checkadmin.count == 0
        Admin.create(username:'系统管理员',login:'admin',password:'admin',password_confirmation:'admin',status:'1',auth:'admin')
      end


      admin = Admin.find_by(login:params[:login][:login])
      if admin && admin.status==0 && admin.authenticate(params[:login][:password])
        redirect_to action: 'index',id:1
      else
        if admin &&  admin.authenticate(params[:login][:password])
          session[:login]= admin.login
          session[:username] = admin.username
          session[:id]=admin.id
          redirect_to users_path
        else
          redirect_to action: 'index',id:0
        end
      end
    end




end
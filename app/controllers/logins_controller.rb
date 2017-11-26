class LoginsController < ApplicationController



    def index
      checkadmin=Admin.all
      if checkadmin.count == 0
        Admin.create(username:'系统管理员',login:'admin',password:'admin',password_confirmation:'admin',status:'1',auth:'region:user:deposit:takeout:card:relation:interest:regioncount:usercount:depositday:depositmonth:admin:interestversion:deposittypedef:relationdef:interestday:log:depositred:takeoutred')
      end

      if params[:command]
        session[:login]= nil
        session[:username] = nil
        session[:id]=nil
        session[:auth]=nil
      end
      @admins = Admin.all
    end

    def create




      admin = Admin.find(params[:login][:login])
      if admin && admin.status==0 && admin.authenticate(params[:login][:password])
        redirect_to action: 'index',id:1
      else
        if admin &&  admin.authenticate(params[:login][:password])
          session[:login]= admin.login
          session[:username] = admin.username
          session[:id]=admin.id
          session[:auth]=admin.auth
          redirect_to users_path
        else
          redirect_to action: 'index',id:0
        end
      end
    end




end

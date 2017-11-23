class SettingsController < ApplicationController
  def index
    @setting = Setting.all
    if @setting.count == 0
      Setting.create(monthday:28)
    end
    @setting = Setting.first
  end

  def savemonthday
    @setting = Setting.first
    @setting.monthday = params[:monthday]
    @setting.save
    Flog.create(log:'编辑月结日期 '+@setting.monthday.to_s+'号',logtype:1,user:session[:username])
    render json: '{"monthday":"'+@setting.to_json+'"}'
  end

end

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
    render json: '{"monthday":"'+@setting.to_json+'"}'
  end

end

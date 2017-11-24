class DepositdayreportsController < ApplicationController
  before_action {authen "depositday"}
  def index
    @nowdate = Time.now.strftime('%Y-%m')
  end

  def getvalue
    date = params[:date]
    title =date
    month = Array.new
    deposit = Array.new
    takeout = Array.new
    Time.parse(date+'-01').end_of_month.day.times do |tice|
      month.push tice + 1
      temday = (tice+1).to_s
      if temday.length == 1
        temday = '0'+temday
      end
      datestr = "%#{date+'-'+temday}%"
      deposit.push Deposit.where('created_at like ?',datestr).sum('amount')
      takeout.push Takeout.where('created_at like ?',datestr).sum('amount')
    end
    render json: '{"title":'+title.to_json+',"month":'+month.to_json+',"deposit":'+deposit.to_json+',"takeout":'+takeout.to_json+'}'
  end

end

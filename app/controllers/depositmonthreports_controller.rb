class DepositmonthreportsController < ApplicationController

  def index
    @nowdate = Time.now.strftime('%Y')

  end

  def getvalue

    date = params[:date]

    title =date
    month = Array.new
    deposit = Array.new
    takeout = Array.new
    Time.parse(date+'-01-01').end_of_year.month.times do |tice|
      month.push (tice + 1).to_s + '月'
      temstr = (tice + 1).to_s
      if temstr.length == 1
        temstr ='0'+temstr
      end
      datestr = "%#{date+'-'+temstr}%"
      deposit.push Deposit.where('created_at like ?',datestr).sum('amount')
      takeout.push Takeout.where('created_at like ?',datestr).sum('amount')
    end
    render json: '{"title":'+title.to_json+',"month":'+month.to_json+',"deposit":'+deposit.to_json+',"takeout":'+takeout.to_json+'}'
  end

end

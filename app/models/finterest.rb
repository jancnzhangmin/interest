class Finterest < ApplicationRecord
  belongs_to :user

  def self.interest
    users = User.all
    users.each do |user|
      10.times do |tice|
        deposits = user.deposits
        if deposits.count > 0 && deposits.last.created_at < Time.now - tice.day
          #if deposits.count > 0
          interests = user.finterests.where('interestday = ?  and interesttype = 0',(Time.now - tice.day).beginning_of_day)
          if interests.count == 0 && user.capital > 0
            rate = user.interestversion.rate * user.capital
            interests.create(amount:rate,incapitalstatus:0,interesttype:0,interestday:(Time.now - tice.day).beginning_of_day)
            Flog.create(log:'日息计息 '+user.username+':￥'+rate.to_s+' 计息版本'+((Time.now - tice.day).beginning_of_day).strftime('%Y%m%d'),logtype:0,user:'system')
          end
        end
      end
    end
  end

  def self.addinterest
    if Time.now.day == Setting.first.monthday
      users = User.all
      users.each do |user|
        interests = user.finterests.where('incapitalstatus = 0')
        if interests.count > 0
          interestsum = user.finterests.where('incapitalstatus = 0').sum('amount')
          user.capital += interestsum
          user.save
          Flog.create(log:'计入本金 '+user.username+':￥'+interestsum.to_s,logtype:0,user:'system')
          interests.each do |interest|
            interest.incapitalstatus = 1
            interest.save
          end
        end
      end
    end
  end

end

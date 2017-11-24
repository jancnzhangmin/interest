class RegioncountsController < ApplicationController
  before_action {authen "regioncount"}
  def index

  end

  class Userclass
    attr :id,true
    attr :region,true
    attr :interestversion,true
    attr :username,true
    attr :sex,true
    attr :tel,true
    attr :capital,true
  end

  def getuser
    if params[:selfid].to_s == '0'
      users = User.all
    else
      userarr = Array.new
      getregion(params[:selfid],userarr)
      users = User.where('id in (?)',userarr)
    end

    usercount = users.count
    amountcount = users.sum('capital')

    renderuserarr = Array.new
    users.each do |user|
      usercla = Userclass.new
      usercla.id = user.id
      usercla.region = getregiont('',user.region_id)+user.address
      usercla.interestversion = user.interestversion.name
      usercla.username = user.username
      if user.sex == 0
        usercla.sex = '男'
      else
        usercla.sex = '女'
      end
      usercla.tel = user.tel
      usercla.capital = user.capital
      renderuserarr.push usercla
    end
    #render json: renderuserarr.to_json
    render json: '{"user":'+renderuserarr.to_json+',"usercount":'+usercount.to_json+',"amountcount":'+amountcount.to_json+'}'
  end

  private

  def getregion(regionid,userarr)
    region = Region.find(regionid)
    temusers = region.users
    if temusers.count > 0
      temusers.each do |tf|
        userarr.push tf.id
      end
    end
    if region.childrens
      regions = region.childrens
      regions.each do |f|
        getregion(f.id,userarr)
      end
      #return userarr
    end
    #return userarr
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

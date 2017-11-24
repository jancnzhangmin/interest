class UsercountsController < ApplicationController
  before_action {authen "usercount"}
  def index
    @users = User.all.paginate(:page => params[:page], :per_page => 20).order("id desc")
    @userarr=Array.new
    @users.each do |f|
      usercla = Userclass.new
      usercla.id = f.id
      usercla.region_id=f.region_id
      usercla.interestversion = f.interestversion.name
      usercla.username=f.username
      if f.sex == 0
        usercla.sex = '男'
      else
        usercla.sex='女'
      end
      usercla.address=getregiont('',f.region_id)+f.address
      usercla.tel=f.tel
      usercla.content=f.content
      usercla.capital=f.capital
      @userarr.push(usercla)
    end
    @usercount = User.count
    @amountcount = User.sum('capital')
  end

  class Userclass
    attr :id,true
    attr :region_id,true
    attr :interestversion,true
    attr :username,true
    attr :sex,true
    attr :address,true
    attr :tel,true
    attr :content,true
    attr :capital,true
  end

  def getregionall
    regionstr = getregiont('',params[:regionid]) + User.find(params[:userid]).address
    render json: regionstr.to_json
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

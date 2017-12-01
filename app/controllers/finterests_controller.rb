class FinterestsController < ApplicationController
  def index

  end

  def hasinterest
    user=User.find(params[:user_id])
    @interests = user.finterests.where('incapitalstatus = 0').paginate(:page => params[:page], :per_page => 20).order("id desc")
  end

  def nointerest
    user=User.find(params[:user_id])
    @interests = user.finterests.where('incapitalstatus = 1').paginate(:page => params[:page], :per_page => 20).order("id desc")
  end

end

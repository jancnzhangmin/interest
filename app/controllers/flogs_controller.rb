class FlogsController < ApplicationController
  before_action {authen "log"}
  def index
    @flogs = Flog.all.paginate(:page => params[:page], :per_page => 20).order("id desc")
  end
end

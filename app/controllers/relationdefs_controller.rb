class RelationdefsController < ApplicationController
  before_action {authen "relationdef"}
  before_action :set_relationdef, only: [:show, :edit, :update, :destroy]
  def index
    @relationdefs = Relationdef.all

  end

  def edit

  end

  def new
    @relationdef = Relationdef.new
  end

  def create
    @relationdef = Relationdef.new(relationdef_params)
    respond_to do |format|
      if @relationdef.save
        Flog.create(log:'新增社会关系定义 '+@relationdef.relation,logtype:1,user:session[:username])
        format.html { redirect_to relationdefs_path, notice: 'User was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @relationdef.update(relationdef_params)
        Flog.create(log:'编辑社会关系定义 '+@relationdef.relation,logtype:1,user:session[:username])
        format.html { redirect_to relationdefs_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    Flog.create(log:'删除社会关系定义 '+@relationdef.relation,logtype:1,user:session[:username])
    @relationdef.destroy
    respond_to do |format|
      format.html { redirect_to relationdefs_path, notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_relationdef
    @relationdef = Relationdef.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def relationdef_params
    params.require(:relationdef).permit(:relation)
  end
end

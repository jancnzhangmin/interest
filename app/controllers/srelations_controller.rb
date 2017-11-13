class SrelationsController < ApplicationController

  before_action :set_srelation, only: [:show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy, :new, :create, :index]
  def index
    @srelations=@user.srelations
  end

  def edit
    @relationdef=Relationdef.all
  end

  def new

    @relationdef = Relationdef.all
    @srelation = @user.srelations.new

  end

  def create
    @srelation = @user.srelations.new(srelation_params)
    debugger
    respond_to do |format|
      if @srelation.save
        format.html { redirect_to user_srelations_path(@user), notice: 'Unit was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @srelation.update(srelation_params)
        format.html { redirect_to user_srelations_path(@user), notice: 'Unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @srelation }
      else
        format.html { render :edit }
        format.json { render json: @srelation.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @srelation.destroy
    respond_to do |format|
      format.html { redirect_to user_srelations_path(@user), notice: '删除成功' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_srelation
    @srelation = Srelation.find(params[:id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def srelation_params
    params.require(:srelation).permit(:relationdef_id, :user_id, :name, :tel, :address, :content)
  end
end

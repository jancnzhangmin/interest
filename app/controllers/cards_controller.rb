class CardsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @cards = @user.cards
  end

  def new
    @user = User.find(params[:user_id])
    @cards = @user.cards.new
  end

  def create
    @user = User.find(params[:user_id])
    @cards = @user.cards.new(card_params)
    @cards.save
    redirect_to user_cards_path(@user)
  end

  def edit
    @user = User.find(params[:user_id])
    @cards=Card.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @cards=Card.find(params[:id])
    @cards.update(card_params)
    redirect_to user_cards_path(@user)
  end

  def destroy
    @user = User.find(params[:user_id])
    @cards=Card.find(params[:id])
    @cards.destroy
    redirect_to user_cards_path(@user)
  end

  private

  def card_params
    params.require(:card).permit(:name ,:bankdeposit,:bankaccount)
  end

end

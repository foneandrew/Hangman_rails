class GamesController < ApplicationController
  def index
    @games = Game.all.reverse
  end

  def show
    @game = Game.find(params[:id])
    @guessed_letters = @game.guessed_letters
    @obscured_word = @game.guessed_word
  end

  def create
    game = Game.create

    flash.alert = "was not able to create a valid game" unless game.save
    redirect_to game
  end
end

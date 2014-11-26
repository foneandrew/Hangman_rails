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
    game = Game.create!
    redirect_to game
  end
end

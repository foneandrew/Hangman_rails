class GuessedLettersController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    make_guess = MakeGuess.new(game: game, params: params)
    
    error = make_guess.call
    flash.alert = error if error

    redirect_to game
  end
end
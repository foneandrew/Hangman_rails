class GuessedLettersController < ApplicationController
  def create
    game = Game.find(params[:game_id])
    
    guessed_letter = game.guessed_letters.create(params.require(:guessed_letter).permit(:letter))
    
    guessed_letter.save

    redirect_to game
  end
end

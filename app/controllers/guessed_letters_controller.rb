class GuessedLettersController < ApplicationController
  def create
    game = Game.find(params[:game_id])

    unless game.lives_remaining <= 0 || game.word_is_guessed?
      guessed_letter = game.guessed_letters.create(params.require(:guessed_letter).permit(:letter))
      "error??" unless guessed_letter.save
    end

    redirect_to game
  end
end

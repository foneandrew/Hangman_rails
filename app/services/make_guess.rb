class MakeGuess
  def initialize(game:, params:)
    @game = game
    @params = params
  end

  def call
    if @game.game_over?
      "cannot make a guess as the game is already over!"
    else
      guessed_letter = @game.guessed_letters.build(@params.require(:guessed_letter).permit(:letter))

      unless guessed_letter.save
        "Something is borked. #{guessed_letter.errors.full_messages.to_sentence}"
      end
    end
  end
end
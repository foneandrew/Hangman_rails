class MakeGuess
  def initialize(game:, params:)
    @game = game
    @params = params
  end

  def call
    return "Cannot make a guess as the game is already over!" if @game.game_over?
      
    guessed_letter = @game.guessed_letters.build(@params.require(:guessed_letter).permit(:letter))

    return "Cannot add guess: #{guessed_letter.errors.full_messages.to_sentence}" unless guessed_letter.save
  end
end
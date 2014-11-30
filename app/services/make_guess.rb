class MakeGuess
  attr_reader :error_message
  
  def initialize(game:, letter:)
    @game = game
    @letter = letter
  end

  def call
    if @game.game_over?
      @error_message = "Cannot make a guess as the game is already over!" 
      return false
    end
      
    guessed_letter = @game.guessed_letters.build(letter: @letter)

    unless guessed_letter.save
      @error_message = "Cannot add guess: #{guessed_letter.errors.full_messages.to_sentence}"
      return false
    end

    return true
  end
end
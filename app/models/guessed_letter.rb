class GuessedLetter < ActiveRecord::Base
  belongs_to :game
  validates :letter, 
    presence: true, 
    format: { with: /\A[a-z]\z/ },
    uniqueness: { scope: :game_id }
  validate :game_is_in_progress?

  def correct?
    game.secret_word.include? letter
  end

  private

  def game_is_in_progress?
    errors.add :game_id, 'cannot add guess to a game that is not in progress' if game.lives_remaining <= 0 || game.word_is_guessed?
  end
end

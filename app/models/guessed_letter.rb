class GuessedLetter < ActiveRecord::Base
  belongs_to :game
  before_validation :downcase_letter
  validates :letter, 
    presence: true, 
    format: { with: /\A[a-z]\z/ },
    uniqueness: { scope: :game_id }
  validate :game_is_in_progress?

  scope :alphabetical_order, -> { order(:letter) }

  def correct?
    game.secret_word.include? letter
  end

  private

  def game_is_in_progress?
    #note currently semi-broken as the game will know its over before the record is actually saved and verified
    errors.add :game_id, 'cannot add guess to a game that is not in progress' if game.lives_remaining < 0 || game.word_is_guessed?
  end

  def downcase_letter
    self.letter = letter.downcase
  end
end

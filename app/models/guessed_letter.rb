class GuessedLetter < ActiveRecord::Base
  belongs_to :game
  before_validation :downcase_letter
  validates :letter, 
    presence: true, 
    format: { with: /\A[a-z]\z/ },
    uniqueness: { scope: :game_id }

  scope :alphabetical_order, -> { order(:letter) }

  def correct?
    game.secret_word.include? letter
  end

  private

  def downcase_letter
    self.letter = letter.downcase
  end
end

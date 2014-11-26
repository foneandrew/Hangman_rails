class GuessedLetter < ActiveRecord::Base
  belongs_to :game
  validates :letter, 
    presence: true, 
    format: { with: /\A[a-z]\z/ },
    uniqueness: { scope: :game_id }

  def correct?
    game.secret_word.include? letter
  end
end

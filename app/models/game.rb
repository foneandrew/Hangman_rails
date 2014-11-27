class Game < ActiveRecord::Base
  MAX_LIVES = 8
  WORD_LIST_PATH = Rails.root.join("app", "assets", "words.txt")

  has_many :guessed_letters, dependent: :destroy

  before_validation :setup_new_word, on: :create
    #use self.whatever to initialize fields
  validates :secret_word, presence: true

  def wrong_guesses
    guessed_letters - correct_guesses
  end

  def correct_guesses
    guessed_letters.select(&:correct?)
  end

  def partially_revealed_word
    correctly_guessed_letters = correct_guesses.map(&:letter)
    secret_word.chars.map { |letter| letter if correctly_guessed_letters.include?(letter) }
  end

  def lives_remaining
    MAX_LIVES - wrong_guesses.length
  end

  def game_won?
    (secret_word.chars.uniq - guessed_letters.map(&:letter).uniq).empty?
  end

  def game_lost?
    lives_remaining <= 0
  end

  def game_over?
    game_won? || game_lost?
  end

  private

  def setup_new_word
    self.secret_word ||= random_word
  end

  def random_word
    File.read(WORD_LIST_PATH).split.first(5000).sample
  end
end

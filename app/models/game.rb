class Game < ActiveRecord::Base
  MAX_LIVES = 8
  WORD_LIST_PATH = Rails.root.join("app", "assets", "words.txt")

  has_many :guessed_letters, dependent: :destroy

  before_validation :setup_new_word
    #use self.whatever to initialize fields
  validates :secret_word, presence: true

  def wrong_guesses
    guessed_letters - correct_guesses
  end

  def correct_guesses
    guessed_letters.select(&:correct?)
  end

  def partially_revealed_word
    guessed_letters = correct_guesses.map(&:letter)
    secret_word.chars.map{|letter| letter if guessed_letters.include? letter}
  end

  def lives_remaining
    MAX_LIVES - wrong_guesses.length
  end

  def word_is_guessed?
    (secret_word.chars.uniq - guessed_letters.map(&:letter).uniq).empty?
  end

  private

  def setup_new_word
    self.secret_word ||= random_word
  end

  def random_word
    File.read(WORD_LIST_PATH).split.first(5000).sample
  end
end

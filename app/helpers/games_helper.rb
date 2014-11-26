module GamesHelper
  def obscured_word(word)
    word.map do |letter|
      if letter
        "#{letter.upcase} "
      else
        "- "
      end
    end.join
  end

  def guess_list(guessed_letters)
    guessed_letters.map do |letter|
      content_tag :span, letter.letter
    end.sort.to_sentence
  end

  def game_over?(game)
    game_won?(game) || game_lost?(game)
  end

  def game_won?(game)
    game.word_is_guessed?
  end

  def game_lost?(game)
    game.lives_remaining <= 0
  end

  def game_name(game)
    if game_won?(game)
      "GAME WON -- [#{game.secret_word.upcase}] (#{game.lives_remaining} lives remaining)"
    elsif game_lost?(game)
      "GAME LOST -- [#{obscured_word(game.guessed_word)}] (word: #{game.secret_word})"
    else
      "IN PROGRESS -- [#{obscured_word(game.guessed_word)}] (#{game.lives_remaining} lives remaining)"
    end
  end
end

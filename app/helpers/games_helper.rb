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

  def hangman_image(game)
    Game::MAX_LIVES - game.lives_remaining
  end

  def guess_list(guessed_letters)
    guessed_letters.map do |letter|
      content_tag :span, letter.letter, class: (letter.correct? ? :correct_letter : :wrong_letter)
    end.to_sentence
  end

  def end_game_message(game)
    if game_won?(game)
      content_tag :span, "YOU WON!", class: :game_won_message
    elsif game_lost?(game)
      content_tag :span, "YOU LOST! (the word was #{game.secret_word.upcase})", class: :game_lost_message
    end
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

  def game_description(game)
    if game_won?(game)
      content_tag :span, "GAME WON [#{game.secret_word.upcase}] (#{game.lives_remaining} lives remaining)", class: :game_won
    elsif game_lost?(game)
      content_tag :span, "GAME LOST [#{obscured_word(game.guessed_word)}] (word: #{game.secret_word})", class: :game_lost
    else
      content_tag :span, "IN PROGRESS [#{obscured_word(game.guessed_word)}] (#{game.lives_remaining} lives remaining)", class: :game_in_progress
    end
  end
end

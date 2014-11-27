module GamesHelper
  def obscured_word(game)
    game.partially_revealed_word.map do |letter|
      if letter
        "#{letter.upcase} "
      else
        "- "
      end
    end.join
  end

  def hangman_image(game)
    "dead_guy_#{Game::MAX_LIVES - game.lives_remaining}.png"
  end

  def guess_list(game)
    game.guessed_letters.alphabetical_order.map do |letter|
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

  def global_game_statistics
    total_games = Game.all
    games_won = total_games.select{|game| game.word_is_guessed?}
    games_lost = total_games.select{|game| game.lives_remaining <= 0}
    avg_lives_remaining = games_won.map{|game| game.lives_remaining}.sum / (games_won.length + 0.0)

    "Total games played: #{total_games.length}, Games won: #{games_won.length}, Games lost: #{games_lost.length}, average lives remaining: #{avg_lives_remaining.round(1)}"
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
      content_tag :span, "[#{game.secret_word.upcase}] (won with #{game.lives_remaining} lives remaining)", class: :game_won
    elsif game_lost?(game)
      content_tag :span, "[#{obscured_word(game)}] (lost, word was: #{game.secret_word.upcase})", class: :game_lost
    else
      content_tag :span, "IN PROGRESS [#{obscured_word(game.currently_guessed_word)}] (#{game.lives_remaining} lives remaining)", class: :game_in_progress
    end
  end
end

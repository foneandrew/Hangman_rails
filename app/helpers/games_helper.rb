module GamesHelper
  def obscured_word(game)
    game.partially_revealed_word.map do |letter|
      if letter
        letter.upcase
      else
        '-'
      end
    end.join(' ')
  end

  def hangman_image(game)
    return "dead_guy_won.png" if game.game_won?
    "dead_guy_#{Game::MAX_LIVES - game.lives_remaining}.png"
  end

  def guess_list(game)
    game.guessed_letters.alphabetical_order.map do |letter|
      content_tag :span, letter.letter, class: (letter.correct? ? :correct_letter : :wrong_letter)
    end.to_sentence
  end

  def end_game_message(game)
    if game.game_won?
      content_tag :span, "YOU WON!", class: :game_won_message
    elsif game.game_lost?
      content_tag :span, "YOU LOST! (the word was #{game.secret_word.upcase})", class: :game_lost_message
    end
  end

  def global_game_statistics(total_games:, games_won:, games_lost:, avg_lives_remaining:)
    "Total games played: #{total_games}, Games won: #{games_won}, Games lost: #{games_lost}, average lives remaining: #{avg_lives_remaining.round(1)}"
  end

  def game_description(game)
    if game.game_won?
      content_tag :span, "#{game.secret_word.upcase} (won with #{game.lives_remaining} lives remaining)", class: :game_won
    elsif game.game_lost?
      content_tag :span, "#{obscured_word(game)} (lost, word was: #{game.secret_word.upcase})", class: :game_lost
    else
      content_tag :span, "Still going! [#{obscured_word(game)}] (#{game.lives_remaining} lives remaining)", class: :game_in_progress
    end
  end
end

class GamesOverviewStats
  def initialize(games_set:)
    @total_games_set = games_set
    @games_won_set = @total_games_set.select{|game| game.game_won?}
  end

  def total_games
    @total_games ||= @total_games_set.length
  end

  def games_won
    @games_won ||= @games_won_set.length
  end

  def games_lost
    @games_lost ||= @total_games_set.select{|game| game.game_lost?}.length
  end

  def avg_lives_remaining
    @avg_lives_remaining ||= @games_won_set.map{|game| game.lives_remaining}.sum / (games_won.to_f)
  end
end
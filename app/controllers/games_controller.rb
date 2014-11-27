class GamesController < ApplicationController
  def index
    @games = Game.all.reverse

    total_games_set = Game.all
    games_won_set = total_games_set.select{|game| game.game_won?}

    @total_games = total_games_set.length
    @games_won = games_won_set.length
    @games_lost = total_games_set.select{|game| game.game_lost?}.length
    @avg_lives_remaining = games_won_set.map{|game| game.lives_remaining}.sum / (@games_won.to_f)
  end

  def show
    @game = Game.find(params[:id])
  end

  def create
    game = Game.create

    flash.alert = "was not able to create a valid game" unless game.save
    redirect_to game
  end
end

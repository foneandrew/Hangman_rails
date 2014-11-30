class GamesController < ApplicationController
  def index
    @games = Game.all.reverse
    @games_stats = GamesOverviewStats.new(games_set: Game.all)
  end

  def show
    @game = Game.find(params[:id])
  end

  def create
    game = Game.new

    flash.alert = "was not able to create a valid game" unless game.save

    redirect_to game
  end
end
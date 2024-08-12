class UserStatController < ApplicationController

  def index
    user_stats = UserStat.all
    render json: user_stats
  end

  def show
    user_stat = UserStat.find(params[:id])
    render json: user_stat
  end

  def create
    # puts "Creating user stat"
    # puts params
    user_stat = UserStat.new(params.require(:user_stat).permit(:wins, :lost, :games_played, :right_guesses, :skips))
    user_stat.save
  end

end

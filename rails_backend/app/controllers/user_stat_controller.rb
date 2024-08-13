class UserStatController < ApplicationController

  def index
    user_stats = UserStat.all
    render json: user_stats, status: :ok
  end

  def show
    user_stat = UserStat.find(params[:id])
    render json: user_stat, status: :ok
  end

  def update
    user_stat = UserStat.find(params[:id])
    if user_stat.update(params.require(:user_stat).permit(:wins, :lost, :games_played, :right_guesses, :skips))
      render json: user_stat, status: :ok
    else
      render json: user_stat.errors, status: :unprocessable_entity
    end
  end

end

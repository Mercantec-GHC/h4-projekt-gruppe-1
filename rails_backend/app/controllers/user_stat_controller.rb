class UserStatController < ApplicationController

  def index
    user_stats = UserStat.all
    render json: user_stats, status: :ok
  end

  def show
    user_stat = UserStat.find(params[:id])
    render json: user_stat, status: :ok
  end


  def create
    user_stat = UserStat.new(:wins => 0, :lost => 0, :games_played => 0, :right_guesses => 0, :skips => 0)
    if user_stat.save
      render json: user_stat, status: :created
    else
      render json: user_stat.errors, status: :unprocessable_entity
    end
  end
    

  def update
    user_stat = UserStat.find(params[:id])
    if user_stat.update(params.require(:user_stat).permit(:wins, :lost, :games_played, :right_guesses, :skips))
      render json: user_stat, status: :ok
    else
      render json: user_stat.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @user_stat = UserStat.find(params[:id])
    if @user_stat.destroy
      render json: @user_stat, status: :ok
    else
      render json: @user_stat.errors, status: :unprocessable_entity
    end
  end

end

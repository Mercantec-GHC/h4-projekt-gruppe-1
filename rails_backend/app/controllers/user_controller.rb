class UserController < ApplicationController
  def index
    user = User.all
    render json: user , except: [:id, :created_at, :updated_at], status: :ok
  end

  def show
    user = User.find(params[:id])
    user.match_ids
    match = Match.find(user.match_ids)
    render json: match, except: [:id, :created_at, :updated_at], status: :ok
  end

  def create
    # user = User.new(user_params)
    # user.user_stat = UserStat.create(wins: 0, lost: 0, games_played: 0, right_guesses: 0, skips: 0)
    # if user.save
    #   render json: user, status: :created
    # else
    #   render json: user.errors, status: :unprocessable_entity
    # end
  
  end

  def update
    user = User.find(params[:id])
    if user.nil?
      render jsom: {error: "User not found"}, status: :not_found 
      return
    end
    if user.update(user_params)
      render json: user, status: :ok
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    user_stat = UserStat.find(user.user_stat.id)
    user.destroy
    user_stat.destroy
    render json: user, status: :ok
  end
end

private
def user_params
  reparams.require(:user).permit(:name, :nick_name, :email, :password, :number)
end
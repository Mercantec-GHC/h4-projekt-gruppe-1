class MatchController < ApplicationController
  def show
    match = Match.find(params[:id])
    render json: match, except: [:id, :created_at, :updated_at], status: :ok
  end

  def create

    match = Match.new(match_params)
    if match.save
      match.user_ids = params[:user_ids]
      render json: match, status: :created
    else
      render json: match.errors, status: :unprocessable
    end
  end

  def update
  end

  def destroy
  end

  def index
    matches = Match.all
    render json: matches, except: [:id, :created_at, :updated_at], status: :ok
  end



  private

  def match_params
    params.require(:match).permit(:winner, :loser, :player_1_points, :player_2_points, :draw)
  end
end



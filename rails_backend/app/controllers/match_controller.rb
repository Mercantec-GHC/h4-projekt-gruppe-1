class MatchController < ApplicationController
  def show
    match = Match.find(params[:id])
    render json: match, except: [:id, :created_at, :updated_at], status: :ok
  end

  def create

    match = Match.new(match_params)
    if match.save
      match.user_ids = params[:user_ids] if params[:user_ids].present?
      render json: match, status: :created
    else
      render json: match.errors, status: :unprocessable
    end
  end

  def update
    match = Match.find(params[:id])
    if match.update(match_params)
      match.user_ids = params[:user_ids] if params[:user_ids].present?
      render json: match, status: :ok
    else
      render json: match.errors, status: :unprocessable
    end
  end

  def destroy
    match = Match.find(params[:id])
    if match
      match.user_ids = []
      match.destroy
      render json: match, status: :ok
    else
      render json: {error: "Match not found"}, status: :not_found
    end
  end

  def index
    matches = Match.all
    render json: matches, except: [:id, :created_at, :updated_at], status: :ok
  end



  private

  private

def match_params
  params.fetch(:match, {}).permit(:winner, :loser, :player_1_points, :player_2_points, :draw, :player_1_user_name, :player_2_user_name, :player_1_comment, :player_2_comment)
        .tap do |match_params|
          match_params[:winner] ||= 'N/A'
          match_params[:loser] ||= 'N/A'
          match_params[:player_1_points] ||= 0
          match_params[:player_2_points] ||= 0
          match_params[:draw] ||= false
          match_params[:player_1_comment] ||= ''
          match_params[:player_2_comment] ||= ''
          match_params[:player_1_user_name] ||= 'Unknown'
          match_params[:player_2_user_name] ||= 'Unknown'
        end
end

  
end



class MatchController < LoginController
  # This controller is used to alle endpoints related to matches

  # Fetches a match from the database GET /matches/:id
  def show
    match = Match.find(params[:id])
    if match
      render json: match, except: [ :created_at, :updated_at], status: :ok
    else
      render json: {error: "Match not found"}, status: :not_found
    end
  end

  # Creates a match in the database POST /matches
  def create
    match = Match.new(match_params)
    match.timer = 60
    if match.save
      match.user_ids = params[:user_ids] if params[:user_ids].present?
      render json: match, status: :created
    else
      render json: match.errors, status: :unprocessable
    end
  end

  # Updates a match in the database PUT /matches/:id this endpoint ended up not being used in the final version of the app
  def update
    match = Match.find(params[:id])
    if match.update(match_params)
      match.user_ids = params[:user_ids] if params[:user_ids].present?
      render json: match, status: :ok
    else
      render json: match.errors, status: :unprocessable
    end
  end

 # Deletes a match from the database DELETE /matches/:id this endpoint ended up not being used in the final version of the app
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

  # Fetches all matches from the database GET /matches this endpoint ended up not being used in the final version of the app
  def index
    matches = Match.all
    render json: matches, except: [:id, :created_at, :updated_at], status: :ok
  end



  private


# This method is used to permit the parameters that are allowed to be passed to the controller, it also sets default values for the parameters if its not passed
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
          match_params[:player_1_user_name] ||= ' '
          match_params[:player_2_user_name] ||= ' '
        end
end

  
end



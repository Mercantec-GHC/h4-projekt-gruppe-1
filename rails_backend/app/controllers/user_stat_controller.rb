class UserStatController < LoginController
  # This controller is used to alle endpoints related to user stats


  # Fetches all user stats from the database GET /user_stats this endpoint ended up not being used in the final version of the app
  def index
    user_stats = UserStat.all
    render json: user_stats, status: :ok
  end
  
  # Fetches a user stat from the database GET /user_stats/:id
  def show
    user_stat = UserStat.find_by(user_id: params[:id])
    if user_stat.nil?
      user_stat = UserStat.new(:wins => 0, :lost => 0, :games_played => 0, :right_guesses => 0, :skips => 0, :user_id => params[:id])
    end
      user_stat.save
    render json: user_stat, status: :ok
  end

  # Creates a user stat in the database POST /user_stats this endpoint ended up not being used in the final version of the app
  def create
    user_stat = UserStat.new(:wins => 0, :lost => 0, :games_played => 0, :right_guesses => 0, :skips => 0)
    if user_stat.save
      render json: user_stat, status: :created
    else
      render json: user_stat.errors, status: :unprocessable_entity
    end
  end
    
  # Updates a user stat in the database PUT /user_stats/:id this endpoint ended up not being used in the final version of the app
  def update
    user_stat = UserStat.find(params[:id])
    if user_stat.update(params.require(:user_stat).permit(:wins, :lost, :games_played, :right_guesses, :skips))
      render json: user_stat, status: :ok
    else
      render json: user_stat.errors, status: :unprocessable_entity
    end
  end

  # Deletes a user stat from the database DELETE /user_stats/:id 
  def destroy
    @user_stat = UserStat.find(params[:id])
    if @user_stat.destroy
      render json: @user_stat, status: :ok
    else
      render json: @user_stat.errors, status: :unprocessable_entity
    end
  end



end

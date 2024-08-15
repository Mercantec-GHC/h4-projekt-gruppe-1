class UserStatController < LoginController
  # before_action :json_token

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



  private

  def json_token 
    token = request.headers["Authorization"]&.split(" ")&.last
    if token
      begin
        decoded_token = JWT.decode(token, ENV['JWT_SECRET'], true, {algorithm: "HS256"})
        @test_user = TestUser.new(decoded_token[0]["sub"], "12345678")
      rescue JWT::DecodeError
        render json: {error: "Invalid token"}, status: :unauthorized
      end
    else
      render json: {error: "No token"}, status: :unauthorized
    end
  end
end

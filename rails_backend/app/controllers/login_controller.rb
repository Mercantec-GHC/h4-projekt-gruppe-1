class LoginController < ApplicationController
 #This controller is for validating the token before accessing the endpoints

 before_action :json_token


 private
  #decodes the token and checks if it is valid
  def json_token 
    token = request.headers["Authorization"]&.split(" ")&.last

    if token
      begin
        decoded_token = JWT.decode(token, ENV['JWT_SECRET'], true, {algorithm: "HS256"})
      rescue JWT::DecodeError
        render json: {error: "Invalid token"}, status: :unauthorized
      end
    else
      render json: {error: "No token"}, status: :unauthorized
    end
  end
end

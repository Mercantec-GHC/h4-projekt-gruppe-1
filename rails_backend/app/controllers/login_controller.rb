class LoginController < ApplicationController
 before_action :json_token


 private

  def json_token 
    token = request.headers["Authorization"]&.split(" ")&.last
    puts JWT.decode(token, ENV['JWT_SECRET'], true, {algorithm: "HS256"})

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

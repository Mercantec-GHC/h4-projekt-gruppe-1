class UserController < ApplicationController
  def index
    users = User.all
    render json: users
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    user = User.new(params.require(:user).permit(:name, :nick_name, :email, :password, :number))
    user.save
  end

  def update
  end

  def delete
  end
end

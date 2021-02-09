class UsersController < ApplicationController
  before_action :authenticate_user, only: [:destroy]

  def create
    user = User.new(user_params)
    if user.save 
      render status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy 
    user = User.find(current_user.id)
    user.destroy
  end

  private 

  def user_params 
    params.require(:user).permit(:email, :password)
  end 
end

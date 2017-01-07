require 'byebug'
class UsersController < ApplicationController
  before_action :authenticate_user, except: [:create]
  def create
    @user = User.new(user_params)
    if @user.save
      # TODO: add test for token
      token = Knock::AuthToken.new(payload: { sub: @user.id }).token
      render json: { jwt: token }, status: 201
    else
      render json: @user.errors, status: 400
    end
  end

  def show
    # ensure requested resource is current_user
    if params[:id] && params[:id] == current_user.id.to_s
      render json: current_user, status: 200
    else
      render json: {}, status: 401
    end
  end

  def destroy
    # ensure requested resource is current_user
    if params[:id] && params[:id] == current_user.id.to_s
      user = User.find(params[:id])
      user.active = false
      user.save
      render json: {}, status: 200
    else
      render json: {}, status: 401
    end
  end

  def update
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:email, :password, :username)
  end
end

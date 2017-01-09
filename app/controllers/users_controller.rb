class UsersController < ApplicationController
  before_action :authenticate_user, except: [:create]
  def create
    @user = User.new(user_params)
    if @user.save
      # TODO: add test for token
      token = Knock::AuthToken.new(payload: { sub: @user.id }).token
      render json: { jwt: token }, status: 201
    else
      render json: @user.errors.messages, status: 400
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
    # ensure two things:
    # 1) current_user can only delete self
    # 2) errors are caught if deletion fails
    if params[:id] && params[:id] == current_user.id.to_s
      User.find(current_user.id).destroy!
      render json: {}, status: 200
    end
  rescue StandardError
    # #destroy! failed
    render json: {}, status: 400
  end

  def update
  end

  private

  def user_params
    params.fetch(:user, {}).permit(:email, :password, :username)
  end
end

class UsersController < ApplicationController
  before_action :require_jwt, except: %i[create]
  protect_from_forgery with: :null_session

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(username: permitted_parameters[:username])
    if @user
      render json: @user
    else
      render json :@user.errors
    end
  end

  def create
    @user = User.new permitted_parameters
    if @user.save
      render json: @user
    else
      render json: @user.errors
    end
  end

  def edit; end

  def update
    if @user.update permitted_parameters
      render json: @user
    else
      render json: @user.errors
    end
  end

  def destroy
    if find_user
      find_user.destroy
      render json: { message: 'Deleted' }
    else
      render :new
    end
  end

  private

  def permitted_parameters
    params.require(:user).permit(:name, :surname, :username, :email, :password, :role)
  end
end

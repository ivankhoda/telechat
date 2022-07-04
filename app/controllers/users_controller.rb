class UsersController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new permitted_parameters
    if @user.save
      render json: { message: "user #{@user.name} was created successfully" }
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(permitted_parameters)
      render json: { message: "user #{@user.name} was updated successfully" }
    else
      render :new
    end
  end

  protected

  def permitted_parameters
    params.require(:user).permit(:username, :role)
  end
end

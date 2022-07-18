class AuthenticationController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :require_jwt, except: %i[create]

  def create
    user = User.find_by(email: login_params[:email])
    if user && user.authenticate(login_params[:password])
      token = encode_user_data({ user: user.email, user_id: user.id.to_s, user_name: user.name,
                                 user_surname: user.surname, user_role: user.role })
      render json: { token:, username: user.username, userId: user.id }
    else
      render json: { message: 'Invalid email/password combination' }
    end
  end

  def destroy
    log_out
    render json: { message: 'You succesfully logout' }
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end

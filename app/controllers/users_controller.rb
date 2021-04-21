class UsersController < ApplicationController
  def show; end

  def authenticate
    user = User.find_by(email: params[:email])&.authenticate(params[:password])
    if user
      session[:user_id] = user.id
      redirect_to '/'
    else
      redirect_to '/login', alert: 'Wrong input!'
    end
  end
end

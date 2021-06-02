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

  def confirm
    user = User.find_by(id: params[:id])
    user.confirmed = true
    if user.save
      redirect_to '/'
    else
      render file: 'public/500.html', status: :not_acceptable, layout: false
    end
  end
end

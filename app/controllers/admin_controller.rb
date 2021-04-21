class AdminController < ApplicationController
  before_action :check_admin
  layout 'admin'

  private

  def check_admin
    @current_user = User.find(session[:user_id]) if session[:user_id]
    redirect_to "/login" unless @current_user&.admin?
  end
end

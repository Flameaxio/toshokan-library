module CurrentUserConcern
  extend ActiveSupport::Concern

  included do
    before_action :set_current_user
  end

  attr_reader :current_user

  def set_current_user
    @current_user = nil
    @current_user = User.find(session[:user_id]) if session[:user_id]
  end
end

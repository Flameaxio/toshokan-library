module Api
  module V1
    module Users
      class RegistrationsController < ApiController
        def create
          user = User.create(user_params)

          if user
            ConfirmationsMailer.confirmation(user, request.base_url).deliver
            #session[:user_id] = user.id
            render json: {
              status: 200
            }
          else
            render json: {
              status: 500
            }
          end
        end

        private

        def user_params
          params.require(:user).permit(:email, :password, :password_confirmation)
        end
      end
    end
  end
end

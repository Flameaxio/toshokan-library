module Api
  module V1
    module Users
      class RegistrationsController < ApiController
        def create
          user = User.create(user_params)

          if user
            session[:user_id] = user.id
            render json: {
              status: :created,
              user: user
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

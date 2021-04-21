module Api
  module V1
    module Users
      class SessionsController < ApiController
        include CurrentUserConcern

        def create
          user = User.find_by(email: params[:user][:email])&.authenticate(params[:user][:password])
          if user
            session[:user_id] = user.id
            render json: {
              status: :created,
              logged_in: true,
              user: user
            }
          else
            render json: {
              status: 401,
              error: 'No such user!'
            }
          end
        end

        def logged_in
          if session[:user_id]
            render json: {
              logged_in: true,
              user: current_user.as_json.merge({ subscription: SubscriptionSerializer.new(current_user.subscription).serialized_json })
            }
          else
            render json: {
              logged_in: false
            }
          end
        end

        def logout
          reset_session
          session.clear
          @current_user = nil
          render json: { status: 200, logged_out: true }
        end

        def subscription
          render json: SubscriptionSerializer.new(current_user.subscription, { params: { current_user: current_user } })
        end
      end
    end
  end
end

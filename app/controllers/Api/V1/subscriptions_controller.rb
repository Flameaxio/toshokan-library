module Api
  module V1
    class SubscriptionsController < ApiController
      include CurrentUserConcern
      def index
        render json: SubscriptionSerializer.new(Subscription.all, params: {current_user: current_user})
      end

      def subscribe
        current_user.subscription = Subscription.all[params[:id].to_i]
        if current_user.save
          render json: {
            status: 200,
            id: params[:id]
          }
        else
          render json: {
            status: 500
          }
        end
      end
    end
  end
end

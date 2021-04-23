module Api
  module V1
    class MessagesController < ApiController
      include CurrentUserConcern

      after_action :publish_message, only: %i[create]

      def publish_message
        return if @message.errors.any?

        json = @message.attributes.merge('user_id' => @message.user.id,
                                         'chat_user_id' => @message.chat.user.id,
                                         'chat_id' => @message.chat.id)
        ActionCable.server.broadcast 'chat_channel', json
      end

      def index
        unless current_user.chat
          chat = Chat.create
          current_user.chat = chat
        end
        render json: { messages: current_user.chat.messages }
      end

      def create
        if current_user.admin? && params[:chat_id] && params[:user_id]
          @chat = Chat.find(params[:chat_id])
          @user = User.find(params[:user_id])
        else
          @chat = current_user.chat
          @chat ||= Chat.create
          current_user.chat = @chat
          @user = current_user
        end
        @message = @chat.messages.build(message_params)
        @message.user = @user
        if @message.save
          render json: { status: 200 }
        else
          render json: { errors: @message.errors.full_messages }, status: 422
        end
      end

      private

      def message_params
        params.require(:message).permit(:content)
      end
    end
  end
end

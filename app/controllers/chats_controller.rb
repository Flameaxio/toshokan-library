class ChatsController < AdminController
  include CurrentUserConcern
  def index
    @chats = Chat.all.order(:updated_at)
  end

  def show
    @chat = Chat.find(params[:id])
  end
end

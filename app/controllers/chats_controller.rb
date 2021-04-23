class ChatsController < AdminController
  include CurrentUserConcern
  def index
    unresolved = Chat.where(status: false).joins(:messages).distinct.order(:updated_at).reverse
    resolved = Chat.where(status: true).joins(:messages).distinct.order(:updated_at).reverse
    @chats = unresolved + resolved
  end

  def show
    @chat = Chat.find(params[:id])
  end
end

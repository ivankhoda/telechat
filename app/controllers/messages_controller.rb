class MessagesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :load_entities
  def new
    @message = Message.new
  end

  def create
    @message = Message.create user_id: @user.id,
                              conversation: @conversation,
                              message: message_params[:text]

    ConversationChannel.broadcast_to @conversation, @message
  end

  protected

  def load_entities
    @conversation = Conversation.find_or_create_by(id: message_params[:conversation_id])
    @user = User.find_or_create_by(id: message_params[:user_id])
  end

  def message_params
    params.require(:message).permit(:text, :conversation_id, :user_id)
  end
end

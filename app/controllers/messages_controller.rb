class MessagesController < ApplicationController
  protect_from_forgery with: :null_session, except: %i[index]
  before_action :load_entities, except: %i[index]
  def new
    @message = Message.new
  end

  def index
    messages = Message.where(conversation_id: params['conversation-id'])
    render json: messages
  end

  def create
    @message = Message.create user_id: @user.id,
                              conversation: @conversation,
                              message: message_params[:text]
    if @message.save
      ConversationChannel.broadcast_to @conversation, @message
      Telegram.bot.send_message(chat_id: @conversation.outer_chat_id, text: @message.message)
    else
      p 'head :ok'
    end
  end

  def delete_all
    @messages = Message.where(conversation_id: params['conversation-id'])
    if @messages.delete
      p 'head :ok'
    else
      p 'head :ok'
    end
  end

  protected

  def load_entities
    @conversation = Conversation.find message_params[:conversation_id]
    @user = User.find_or_create_by(id: message_params[:user_id])
  end

  def message_params
    params.require(:message).permit(:text, :conversation_id, :user_id)
  end
end

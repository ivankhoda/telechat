class ConversationChannel < ApplicationCable::Channel
  def subscribed
    ActionCable.server.broadcast('messages', { messages: Message.where(conversation: find_conversation) })

    if find_conversation
      stream_for find_conversation
    else
      reject
    end
  end

  def unsubscribed
    stop_stream_for find_conversation
  end

  private

  def find_conversation
    Conversation.find params[:conversation]
  end
end

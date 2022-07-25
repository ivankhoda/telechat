class ConversationChannel < ApplicationCable::Channel
  def subscribed
    ActionCable.server.broadcast('messages', { messages: Message.where(conversation: params[:conversation]) })
    stream_for find_conversation
  end

  def unsubscribed
    stop_stream_for find_conversation
  end

  private

  def find_conversation
    Conversation.find params[:conversation]
  end
end

class ConversationChannel < ApplicationCable::Channel
  def subscribed
    ActionCable.server.broadcast('messages', { messages: Message.where(conversation: params[:conversation]) })
    conversation = Conversation.find params[:conversation]
    stream_for conversation
  end

  def unsubscribed; end
end

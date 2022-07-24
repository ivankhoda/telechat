class ConversationsChannel < ApplicationCable::Channel
  def subscribed
    ActionCable.server.broadcast('conversations', { conversation: })
    # conversation = Conversation.find params[:conversation]
    # stream_for conversation
  end

  def unsubscribed; end
end

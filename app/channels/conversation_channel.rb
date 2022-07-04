class ConversationChannel < ApplicationCable::Channel
  def subscribed
    room = Conversation.find params[:conversation]
    stream_for conversation
  end
end

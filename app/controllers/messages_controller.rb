class MessagesController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :load_entities

  def create
    @message = Message.create user: current_user,
                              conversation: @conversation,
                              message: params.dig(:message, :message)
  end

  protected

  def load_entities
    @conversation = Conversation.find params.dig(:message, :conversation_id)
  end
end

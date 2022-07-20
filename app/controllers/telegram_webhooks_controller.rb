class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  use_session!
  before_action :load_entities
  # Every update has one of: message, inline_query, chosen_inline_result,
  # callback_query, etc.
  # Define method with the same name to handle this type of update.
  def message(_message)
    @message = Message.create user_id: @user.id,
                              conversation_id: @conversation.id,
                              message: msg
    ConversationChannel.broadcast_to @conversation, @message if @message.save
  end

  private

  def username
    update[:message][:from][:username]
  end

  def name
    update[:message][:from][:first_name]
  end

  def surname
    update[:message][:from][:last_name]
  end

  def load_entities
    @user = User.find_by(id: telegram_id)
    @user ||= User.create!(id: telegram_id, name:, surname:, username:) unless @user

    @conversation = Conversation.find_by(id: chat_id)
    unless @conversation
      @conversation ||= Conversation.create!(id: chat_id,
                                             name: "#{chat_id}")
    end
  end

  def telegram_id
    upd = HashWithIndifferentAccess.new(update)
    upd[:message][:from][:id]
  end

  def chat_id
    upd = HashWithIndifferentAccess.new(update)
    upd[:message][:chat][:id]
  end

  def msg
    update[:message][:text]
  end

  def session_key
    "#{bot.username}:#{chat['id']}:#{from['id']}" if chat && from
  end
end

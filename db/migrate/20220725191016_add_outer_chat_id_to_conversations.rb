class AddOuterChatIdToConversations < ActiveRecord::Migration[7.0]
  def change
    add_column :conversations, :outer_chat_id, :bigint
  end
end

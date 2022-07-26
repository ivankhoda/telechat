class AddCascadeToMessages < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :messages, :conversations
    remove_foreign_key :messages, :users

    add_foreign_key :messages, :conversations, on_delete: :cascade
    add_foreign_key :messages, :users, on_delete: :cascade
  end
end

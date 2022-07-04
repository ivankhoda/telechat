class CreateConversations < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.string :name
      t.string :status

      t.timestamps
    end
  end
end

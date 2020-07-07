class CreateUserChatMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :user_chat_messages do |t|
      t.text :learner_message
      t.text :assistant_response
      t.boolean :mentor, default: false, null: false
      t.integer :user_chat_id

      t.timestamps
    end
    add_index :user_chat_messages, :user_chat_id
  end
end
